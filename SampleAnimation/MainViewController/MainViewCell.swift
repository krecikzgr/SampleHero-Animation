//
//  MainViewCell.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit
import SnapKit

class MainViewCell: UITableViewCell {
    
    fileprivate lazy var activityView: UIView = UIView()
    
    lazy var titleLabel: UILabel = UILabel()
    lazy var avatarView: AvatarView = AvatarView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initialize()
    }
    
    fileprivate func initialize() {
        initAvatarView()
        initTitleLabel()
        initActivityView()
    }
    
    fileprivate func initAvatarView() {
        addSubview(avatarView)
        avatarView.roundViews = true
        
        avatarView.snp.makeConstraints { (make) in
            make.size.equalTo(30)
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
    }
    
    fileprivate func initTitleLabel() {
        titleLabel = UILabel()
        
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {  [unowned self] (make) in
            make.left.equalTo(self.avatarView.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().inset(10)
        }
    }
    
    fileprivate func initActivityView() {
        activityView = UIView()
        addSubview(activityView)

        activityView.snp.makeConstraints({ [unowned self] make in
            make.left.equalTo(self.titleLabel.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
        })
    }
    
    func update(viewModel: MainCellViewModel) {
        titleLabel.text = viewModel.title
    }
}
