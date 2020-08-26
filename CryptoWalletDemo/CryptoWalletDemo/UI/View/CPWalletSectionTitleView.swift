//
//  CPWalletSectionTitleView.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SnapKit

class CPCurrencyContainerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupSubViews() {
        
        addSubview(symbolLabel)
        addSubview(amountLabel)
        addSubview(currencyLabel)
        
        symbolLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        amountLabel.snp.makeConstraints { (make) in
            make.left.equalTo(symbolLabel.snp.right).offset(2.0)
            make.top.bottom.equalToSuperview()
        }
        
        currencyLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(amountLabel.snp.right).offset(2.0)
        }
    }
    
    func refreshUI(infos: (String, String)) {
        //todo refresh for network data
        amountLabel.text = infos.0
        currencyLabel.text = infos.1
    }
    
    //MARK: - Property
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        //TODO 网络层封装好后删除
        label.text = "$"
        label.textColor = .gray
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textColor = .white
        return label
    }()
    
    lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        label.textColor = .gray
        return label
    }()
}


class CPWalletSectionTitleView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
     
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        
        backgroundColor = .blue
        
        let tipsContainer = UIView()
        tipsContainer.backgroundColor = .clear
        addSubview(tipsContainer)
        
        tipsContainer.addSubview(tipsIcon)
        tipsContainer.addSubview(tipsLabel)
        
        addSubview(amountView)
        addSubview(sendView)
        addSubview(recievedView)
        
        tipsContainer.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120.0)
            make.height.equalTo(40.0)
        }
        
        tipsIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 20.0,height: 16.0))
        }
        
        tipsLabel.snp.makeConstraints { (make) in
            make.left.equalTo(tipsIcon.snp.right).offset(6.0)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        amountView.snp.makeConstraints { (make) in
            make.top.equalTo(tipsContainer.snp.bottom).offset(20.0)
            make.centerX.equalToSuperview()
        }
        
        sendView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-40.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
        
        recievedView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(40.0)
            make.bottom.equalToSuperview().offset(-20.0)
        }
    }
    
    
    public func refreshUI(data: Any?) {
        guard let turple = data as? (String, String) else { return }
        
        amountView.refreshUI(infos: turple)
    }
    
    //MARK: - Property
    
    lazy var tipsIcon: UIImageView = {
        let imgV = UIImageView()
        //随便写个图片
        imgV.image = UIImage(named: "Flag_OMA")
        return imgV
    }()
    
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.text = "crypto.com | WALLET"
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    lazy var amountView: CPCurrencyContainerView = {
        let view = CPCurrencyContainerView()
        return view
    }()
    
    lazy var sendView: CPIConView = {
        let view = CPIConView(iconName: "Glyphs_left_rd", title: "send")
        return view
    }()
    
    lazy var recievedView: CPIConView = {
        let view = CPIConView(iconName: "Glyphs_right_rd", title: "recieved")
        return view
    }()
}
