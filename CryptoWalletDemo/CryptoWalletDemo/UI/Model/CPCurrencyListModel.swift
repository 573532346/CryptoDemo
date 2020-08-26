//
//  CPCurrencyListModel.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SwiftyJSON

class CPCurrencyListModel {

    let coinId: String
    let name: String
    let symbol: String
    let tokenDecimal: Int
    let contractAddress: String
    let colorfulImageUrl: String
    let grayImageUrl: String
    let hasDepositAddressTag: Bool
    let minBalance: Int
    let blockchainSymbol: String
    let tradingSymbol: String
    let code: String
    let explorer: String
    let isErc20: Bool
    let gasLimit: Int
    let tokenDecimalValue: String
    let displayDecimal: Int
    let supportsLegacyAddress: Bool
    let depositAddressTagName: String
    let depositAddressTagType: String
    let numConfirmationRequired: Int
    
    let withdrawalEta: [String]
    
    init(json: JSON) {
        let nJson = JSON(json)
        
        coinId = nJson["coin_id"].stringValue
        name = nJson["name"].stringValue
        symbol = nJson["symbol"].stringValue
        tokenDecimal = nJson["token_decimal"].intValue
        contractAddress = nJson["contract_address"].stringValue
        colorfulImageUrl = nJson["colorful_image_url"].stringValue
        grayImageUrl = nJson["gray_image_url"].stringValue
        hasDepositAddressTag = nJson["has_deposit_address_tag"].boolValue
        minBalance = nJson["min_balance"].intValue
        blockchainSymbol = nJson["blockchain_symbol"].stringValue
        tradingSymbol = nJson["trading_symbol"].stringValue
        code = nJson["code"].stringValue
        explorer = nJson["explorer"].stringValue
        isErc20 = nJson["is_erc20"].boolValue
        gasLimit = nJson["gas_limit"].intValue
        tokenDecimalValue = nJson["token_decimal_value"].stringValue
        displayDecimal = nJson["display_decimal"].intValue
        supportsLegacyAddress = nJson["supports_legacy_address"].boolValue
        depositAddressTagName = nJson["deposit_address_tag_name"].stringValue
        depositAddressTagType = nJson["deposit_address_tag_type"].stringValue
        numConfirmationRequired = nJson["num_confirmation_required"].intValue
        
        withdrawalEta = nJson["withdrawal_eta"].arrayValue.compactMap {
            $0.stringValue
        }
    }
}
