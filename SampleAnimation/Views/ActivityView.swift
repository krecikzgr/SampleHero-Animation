//
//  ActivityView.swift
//  SampleAnimation
//
//  Created by Adrian Kaleta on 03/12/2020.
//

import UIKit

class ActicityView: UIView {
    lazy var dotsView = UIView()
    
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
        addSubview(dotsView)

        dotsView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dotsView.fillWithDots(size: 10, animated: true, color: .lightGray)
    }
}
