//
//  CustomAnimation.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit

final class PresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {


    private let animationDuration: Double
    private let animationType: AnimationType
    
    lazy var initialAvatarView: AvatarView = AvatarView()
    
    weak var startingController: MainViewController?
    weak var destinationController: DetailsController?

    init(animationDuration: Double, animationType: AnimationType) {
        self.animationDuration = animationDuration
        self.animationType = animationType
    }


    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(exactly: animationDuration) ?? 0
    }


    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
              let fromViewController = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        
        switch animationType {
        case .present:
            presentAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        case .dismiss:
            dismissAnimation(
                transitionContext: transitionContext,
                fromView: fromViewController,
                toView: toViewController
            )
        }
    }
    
    func presentAnimation(transitionContext: UIViewControllerContextTransitioning,
                          fromView: UIViewController,
                          toView: UIViewController) {

        let containerView = transitionContext.containerView
        containerView.backgroundColor  = .white

        // Cast the ViewControllers to their original type

        initStartingController(containerView: containerView, controller: fromView)
        initDestinationController(containerView: containerView, controller: toView)
        initStartingAvatar(containerView: containerView,
                           mainController: startingController!)

        let initialAnimation = {
            UIViewPropertyAnimator(duration: animationDuration / 2, curve: .linear) { [weak self] in
                guard let avatar = self?.destinationController?.avatarView else {
                    return
                }
                let frame = self?.getDestinationAvatarFrame(view: containerView,
                                                            destinationAvatar: avatar) ?? .zero
                self?.initialAvatarView.frame.size = frame.size
            }
        }()

        let movementAnimation = {
            UIViewPropertyAnimator(duration: animationDuration / 2, curve: .linear) { [weak self] in
                guard let avatar = self?.destinationController?.avatarView else {
                    return
                }
                self?.initialAvatarView.frame = self?.getDestinationAvatarFrame(view: containerView,
                                                                                destinationAvatar: avatar) ?? .zero
            }
        }()
        
        let rotationAnimation = {
            UIViewPropertyAnimator(duration: animationDuration / 2, curve: .linear) { [weak self] in
                self?.initialAvatarView.transform = CGAffineTransform(rotationAngle: .pi)
                self?.initialAvatarView.transform = CGAffineTransform(rotationAngle: 0)
            }
        }()
        initialAnimation.addCompletion { (_) in
            movementAnimation.startAnimation()
        }
        
        movementAnimation.addCompletion { (_) in
            rotationAnimation.startAnimation()
        }
        
        rotationAnimation.addCompletion { [weak self] (_) in
            self?.showViews()
            self?.initialAvatarView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }

        initialAnimation.startAnimation()
    }

    
    private func initStartingAvatar(containerView: UIView, mainController: MainViewController) {
        let startingAvatar = mainController.getAvatarImage()
        initialAvatarView.frame = getStartingAvatarFrame(view: containerView, startingAvatar: startingAvatar)
        
        containerView.addSubview(initialAvatarView)
        initialAvatarView.layoutSubviews()
    }
    
    private func getStartingAvatarFrame(view: UIView, startingAvatar: AvatarView)->CGRect {
        return view.convert(
            startingAvatar.frame,
            from: startingAvatar.superview
        )
    }
    
    private func getDestinationAvatarFrame(view: UIView, destinationAvatar: AvatarView)-> CGRect {
        return view.convert(
            destinationAvatar.frame,
            from: destinationAvatar.superview
        )
    }
    
    private func initStartingController(containerView: UIView, controller: UIViewController) {
        guard let controller = controller as? MainViewController else {
            return
        }
        startingController = controller
        containerView.addSubview(controller.view)
        startingController?.view.isHidden = true
    }
    
    private func initDestinationController(containerView: UIView, controller: UIViewController) {
        guard let controller = controller as? DetailsController else {
            return
        }
        destinationController = controller
        containerView.addSubview(controller.view)
        destinationController?.view.layoutSubviews()
        destinationController?.view.isHidden = true
    }
    
    private func showViews() {
        startingController?.view.isHidden = false
        destinationController?.view.isHidden = false
    }

    func dismissAnimation(transitionContext: UIViewControllerContextTransitioning,
                          fromView: UIViewController,
                          toView: UIViewController) {

        let containerView = transitionContext.containerView

        containerView.addSubview(toView.view)
        containerView.addSubview(fromView.view)

        transitionContext.completeTransition(true)
    }
}

