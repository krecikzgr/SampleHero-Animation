//
//  UIView+Extensions.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit

extension UIView {
    func fillWithDots(size: CGFloat,
                      animated: Bool,
                      color: UIColor,
                      horizontal: Bool = true) {
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame.size = self.frame.size
        replicatorLayer.masksToBounds = true
        self.layer.addSublayer(replicatorLayer)

        let imageLayer = CALayer()
        imageLayer.backgroundColor = color.cgColor
        imageLayer.frame.size = CGSize(width: size, height: size)
        imageLayer.cornerRadius = size / 2
        replicatorLayer.addSublayer(imageLayer)

        let instanceCount = (horizontal ? self.frame.width : self.frame.height) / size
        replicatorLayer.instanceCount = Int(ceil(instanceCount))
        let delay = TimeInterval(0.1)
        replicatorLayer.instanceDelay = delay

        let xTranslation = horizontal ? size * 2.5 : 0
        let yTranslation = horizontal ? 0 : size * 3.5

        replicatorLayer.instanceTransform = CATransform3DMakeTranslation(
            xTranslation, yTranslation, 0
        )
        guard animated else {
            return
        }
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 1.0
        animation.fromValue = 1.0
        animation.toValue = 0.5
        animation.autoreverses = true
        animation.repeatCount = .infinity
        imageLayer.add(animation, forKey: "hypnoscale")
    }
}
