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
    
    let list: [CPCurrencyListModel]
    let total: Int
    let isOk: Bool
    
    init(json: [AnyHashable: Any]) {
        
        let nJson = JSON(json)
    
        total = nJson["total"].intValue
        isOk = nJson["ok"].boolValue
        
        list = nJson["currencies"].arrayValue.compactMap {
            CPCurrencyListModel(json: $0)
        }
    }
}

class CPRootViewController: CPBaseListViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.view.backgroundColor = .red
    }
}
