//
//  CPRootViewController.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SwiftyJSON

//这两个model在完整的框架中应该是需要放在网络封装的数据层中，鉴于时间有限，先放在ui层


class CPRootViewModel {
    
    var currencys: [CPCurrencyListModel] = []
    var tiers: [CPLiveRatesTiersModel] = []
    
    func update(currencyModel: CPCurrencyModel, ratesModel: CPLiveRatesModel) {
        
        self.currencys = currencyModel.list
        self.tiers = ratesModel.tiers
    }
}


class CPRootViewController: CPBaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        setupSubView()
    }
    
    func setupSubView() {
        
        view.addSubview(titleView)
        view.addSubview(tableView)
        
        titleView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300.0)
        }
        
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Property
    lazy var titleView: CPWalletSectionTitleView = {
        let view = CPWalletSectionTitleView()
        return view
    }()
}
