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
    
    //更新数据
    func update(currencyModel: CPCurrencyModel?, ratesModel: CPLiveRatesModel?) {

        // 因为不清楚业务需求，所以不晓得是否有对应的标志位来确认数据是否为最新的，所以默认每次回调都为新数据，不再做额外的处理
        
        if let wrapCurrModel = currencyModel {
            self.currencys = wrapCurrModel.list
        } else { /* do nothing */ }
        
        
        if let wrapRateModel = ratesModel {
            self.tiers = wrapRateModel.tiers
        } else { /* do nothing */ }
    }

}

typealias CallbackClosure = ([AnyHashable: Any]) -> ()
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
        // 发起网络请求
        doNetworkRequest()
    }
    
    override func registerCells() -> [(Any, String)] {
        return[(CPWalletListCell.self, kCPWalletListCell)]
    }
    
    override func makeDisplayItems() -> [[CPCellItem]] {
        
        let displayItems: [CPCellItem] = viewModel.currencys.compactMap { (model) -> CPCellItem in
            
            let listModel = CPWalletListCellModel(model: model)
            listModel.clickClosure = { [weak self] in
                //todo 点击事件
            }
            
            let item = CPCellItem(kCPWalletListCell, nil, listModel, nil)
            
            return item
        }
        
        return [displayItems]
    }
    
    func doNetworkRequest() {
        // 模仿网络请求： 网络层的逻辑需要对alamofire 进行封装并配合相应的数据编码、json解析、观察者框架的设计和搭建、网络工具类的封装工作量太大几乎等同于做一个全新的app框架，不可能在两天内做出来

        doRequestCurrencyInfo { [weak self] (dict) in
            // 模拟网络观察者框架的回调
        
            let model = CPCurrencyModel(json: dict)
            self?.viewModel.update(currencyModel: model, ratesModel: nil)
            
            // 刷新UI
            self?.refreshUI()
        }
        
        doRequestRatesInfo { [weak self] (dict) in
            // 模拟网络观察者框架的回调
            let model = CPLiveRatesModel(json: dict)
            self?.viewModel.update(currencyModel: nil, ratesModel: model)
            
            // 刷新UI
            self?.refreshUI()
        }
    }
    
    // currency相关的数据获取
    func doRequestCurrencyInfo(closure: CallbackClosure) {
        
        let currencyPath = Bundle.main.path(forResource: "currencyData", ofType: "plist") ?? ""
        let currencyDict = NSDictionary(contentsOfFile: currencyPath) as? Dictionary<String, Any> ?? [:]
        
         closure(currencyDict)
    }
    
    // rates相关的数据获取
    func doRequestRatesInfo(closure: CallbackClosure) {
        let ratesPath = Bundle.main.path(forResource: "ratesList", ofType: "plist") ?? ""
         let ratesDict = NSDictionary(contentsOfFile: ratesPath) as? Dictionary<String, Any> ?? [:]
        
        closure(ratesDict)
    }
    
    //MARK: - Property
    var viewModel = CPRootViewModel()
    
    lazy var titleView: CPWalletSectionTitleView = {
        let view = CPWalletSectionTitleView()
        return view
    }()
}
