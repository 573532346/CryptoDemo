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
import Kingfisher

class CPWalletListCellModel {
    
    let model: CPCurrencyListModel
    
    var clickClosure: (() -> ())?
    
    init(model: CPCurrencyListModel) {
        self.model = model
    }
    
    // 没有需求文档，无法确认数据如果进行二次处理
    // 处理数据逻辑
    var iconUrl: String {
        return model.colorfulImageUrl
    }
    
    var displayName: String {
        return model.name
    }
    
    var displayAmount: String {
        // 没有需求文档不知道怎么处理数据
        return "0.0026" + model.coinId
    }
    
    var displayUSD: String {
        // 没有需求文档不知道怎么处理数据
        return "$" + "1000.00"
    }
}

let kCPWalletListCell = "CPWalletListCell"

class CPWalletListCell: CPBaseListViewCell {
    
    override func setupSubviews() {
        super.setupSubviews()
        
    
        contentView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        // 这里的圆角需要优化，具体用coregraphic,demo不考虑处理
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 4.0
        container.layer.masksToBounds = true
        
        contentView.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(10.0)
            make.bottom.equalToSuperview()
            make.height.equalTo(44.0)
        }
        
        //以下的布局和颜色均需要ui提供，这里仅做粗略的布局
        container.addSubview(icon)
        container.addSubview(symbolLabel)
        container.addSubview(numLabel)
        container.addSubview(usdAmoutLabel)
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(5.0)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(15.0)
        }
        
        symbolLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(icon.snp.right).offset(8.0)
        }
        
        numLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5.0)
            make.top.equalToSuperview().offset(5.0)
        }
        
        usdAmoutLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5.0)
            make.top.equalTo(numLabel.snp.bottom).offset(4.0)
        }
        
    }
    
    override func refresh(_ data: Any?) {
        guard let wrapModel = data as? CPWalletListCellModel else { return }
        
        self.model = wrapModel
        
        // 只做ui渲染，数据逻辑在viewModel中处理完
        symbolLabel.text = wrapModel.displayName
        numLabel.text = wrapModel.displayAmount
        usdAmoutLabel.text = wrapModel.displayUSD
        
        if let url = URL(string: wrapModel.iconUrl) {
            
            let placeHolder = UIImage(named: "icon_common_no web")
            
            icon.kf.setImage(with: url, placeholder: placeHolder)
        } else {/* do nothing */}
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



