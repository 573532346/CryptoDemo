//
//  CPLiveRatesListModel.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SwiftyJSON

class CPLiveRatesListModel {

    let amount: String
    let rate: String
    
    init(json: JSON) {
        amount = json["amount"].stringValue
        rate = json["rate"].stringValue
    }
}

class CPLiveRatesTiersModel {
    
    let fromCurrency: String
    let toCurrency: String
    let timeStamp: TimeInterval
    let rates: [CPLiveRatesListModel]
    
    init(json: JSON) {
        
        fromCurrency = json["from_currency"].stringValue
        toCurrency = json["to_currency"].stringValue
        timeStamp = json["time_stamp"].doubleValue
        
        rates = json["rates"].arrayValue.compactMap {
            CPLiveRatesListModel(json: $0)
        }
    }
    
    /// use the rate with the lowest amount from rates array,
    var usageRateModel: CPLiveRatesListModel? {
        
        // 以amount 作为对比，获取最小值
        let model = rates.min { (lModel, rModel) -> Bool in
            
            let lAmount = Double(lModel.amount) ?? 0.0
            let rAmount = Double(rModel.amount) ?? 0.0
            
            return lAmount < rAmount
        }
        
        //如果找不到对应的model， 则返回nil表示数据异常，则在UI上进行响应的异常处理
        guard let wrapModel = model else { return nil }
        
        return wrapModel
    }
    
}

class CPLiveRatesModel {
    
    let isOk: Bool
    let warning: String
    let tiers: [CPLiveRatesTiersModel]
    
    init(json: [AnyHashable: Any]) {
        let nJson = JSON(json)
        
        isOk = nJson["ok"].boolValue
        warning = nJson["warning"].stringValue
        
        tiers = nJson["tiers"].arrayValue.compactMap {
            CPLiveRatesTiersModel(json: $0)
        }
    }
    
    // 获取对应币种下的汇率model(currency可以考虑使用enum来封装)
    func getRate(with currency: String) -> CPLiveRatesListModel? {
        
        let filterModel = tiers.filter {
            $0.toCurrency == currency
        }.first
        
        // 找不到，则返回nil报错，前端页面做对应的异常逻辑处理
        guard let wrapModel = filterModel else { return nil }
        
        return wrapModel.usageRateModel
    }
}


