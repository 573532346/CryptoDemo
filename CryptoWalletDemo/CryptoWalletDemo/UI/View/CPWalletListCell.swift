//
//  CPWalletListCell.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit

class CPWalletListCellModel {
    
    let model: CPCurrencyListModel
    
    var clickClosure: (() -> ())?
    
    init(model: CPCurrencyListModel) {
        self.model = model
    }
}

class CPWalletListCell: CPBaseListViewCell {
    
    override func setupSubviews() {
        super.setupSubviews()
        
        //以下的布局和颜色均需要ui提供，这里仅做粗略的布局
        contentView.addSubview(icon)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(numLabel)
        contentView.addSubview(usdAmoutLabel)
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15.0)
            make.centerY.equalToSuperview()
        }
        
        symbolLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(8.0)
        }
        
        numLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-15.0)
            make.top.equalToSuperview().offset(5.0)
        }
        
        usdAmoutLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(numLabel.snp.bottom).offset(4.0)
        }
        
    }
    
    override func refresh(_ data: Any?) {
        guard let wrapModel = data as? CPWalletListCellModel else { return }
        
        self.model = wrapModel
    }
    
    //MARK: - Property
    var model: CPWalletListCellModel?
    
    lazy var icon: UIImageView = {
        let imgV = UIImageView()
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var usdAmoutLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
}



