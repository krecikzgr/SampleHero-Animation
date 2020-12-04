//
//  AvatarView.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 04/12/2020.
//

import UIKit
import SnapKit

class AvatarView: UIView {
    
    lazy var icon = UIImageView()
    var roundViews: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView() {
        initTitle()
    }
    
    private func initTitle() {
        addSubview(icon)
        icon.image = UIImage(named: "baseline_person_outline_black_36pt")
        icon.contentMode = .scaleAspectFit

        icon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(4)
            make.left.equalToSuperview().offset(4)
            make.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(4)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius =  roundViews ? frame.width/2 : 0
    }
}
