//
//  CPIConView.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SnapKit

class CPIConView: UIView {

    init(iconName: String, title: String) {
        
        self.iconName = iconName
        self.title = title
        
        super.init(frame: .zero)
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        addSubview(icon)
        addSubview(titleLabel)
        
        icon.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(icon.snp.bottom).offset(2.0)
            make.bottom.equalToSuperview()
        }
        
        icon.image = UIImage(named: iconName)
        titleLabel.text = title
    }
    
    //MARK: - Property
    let iconName: String
    let title: String
    
    lazy var icon: UIImageView = {
        
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
}
