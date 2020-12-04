//
//  DetailsController.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit


class DetailsController: UIViewController  {
    
    lazy var titleLabel: UILabel = UILabel()
    lazy var avatarView: AvatarView = AvatarView()
    lazy var activityIndicator: ActicityView = ActicityView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        view.backgroundColor = .white
        initAvatarView()
        initTitleLabel()
        initActivityIndicator()
    }
    
    private func initTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self.avatarView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func initAvatarView() {
        view.addSubview(avatarView)
        
        avatarView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
            make.top.equalToSuperview().offset(200)
        }
    }
    
    func initActivityIndicator() {
        view.addSubview(activityIndicator)

        activityIndicator.snp.makeConstraints { [unowned self] (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
    }
}
