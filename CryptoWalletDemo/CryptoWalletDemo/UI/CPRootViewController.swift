//
//  CPRootViewController.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJRefresh

//CPRootViewModel管理vc所有的数据及对数据的二次加工
class CPRootViewModel {
    
    var currencys: [CPCurrencyListModel] = []
    
    var ratesModel: CPLiveRatesModel? = nil
    
    //更新数据
    func update(currencyModel: CPCurrencyModel?, ratesModel: CPLiveRatesModel?) {

        // 因为不清楚业务需求，所以不晓得是否有对应的标志位来确认数据是否为最新的，所以默认每次回调都为新数据，不再做额外的处理
        
        if let wrapCurrModel = currencyModel {
            self.currencys = wrapCurrModel.list
        } else { /* do nothing */ }
        
        
        self.ratesModel = ratesModel
    }
    
    //直接在这里处理 头部的账户金额逻辑，这块需要有需求怎么处理数据才能做，
    //（处理后的金额， 比重）
    var displayAmountInfo: (String, String) {
 
        //USD 币种去哪里要，还是说ui可以有切换币种的功能, 这里使用HKD来展示
        
        
        let currency = "USD"

        // 数据异常情况
        guard let wrapModel = ratesModel, let rateModel = wrapModel.getRate(with: currency) else { return ("", "") }
        
        // 账户总金融的计算逻辑是什么不清楚，这里假定从接口中获取到一个值 1000  两个数据进行计算的，需要需求确认逻辑
        let totalAmount: Double = 1000.0
        
        let rateDouble = Double(rateModel.rate) ?? 0.0
        
        let amount = rateDouble * totalAmount
        let amountStr = "\(amount)"
        
        return (amountStr, currency)
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
        
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        view.addSubview(titleSectionView)
        view.addSubview(tableView)
        
        
        titleSectionView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(300.0)
        }
        
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(titleSectionView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        // 发起网络请求
        doNetworkRequest()
        
        // 下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            
            guard let strongSelf = self else { return }
            
            strongSelf.doNetworkRequest()
        })
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
            guard let strongSelf = self else { return }
            // 模拟网络观察者框架的回调
        
            let model = CPCurrencyModel(json: dict)
            self?.viewModel.update(currencyModel: model, ratesModel: nil)
            
            // 刷新UI
            strongSelf.reloadUI()
            strongSelf.tableView.mj_header?.endRefreshing()
        }
        
        doRequestRatesInfo { [weak self] (dict) in
            guard let strongSelf = self else { return }
            // 模拟网络观察者框架的回调
            let model = CPLiveRatesModel(json: dict)
            self?.viewModel.update(currencyModel: nil, ratesModel: model)
            
            strongSelf.reloadUI()
            strongSelf.tableView.mj_header?.endRefreshing()
        }
    }
    
    func reloadUI() {
        
        titleSectionView.refreshUI(data: viewModel.displayAmountInfo)
        refreshUI()
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
    
    lazy var titleSectionView: CPWalletSectionTitleView = {
        let view = CPWalletSectionTitleView()
        return view
    }()
}

extension CPRootViewController {
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0.001
    }
}
