//
//  CPBootService.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit

final class CPBootService: CPAppService {

    init(with window: UIWindow?) {
        self.window = window

    }
    
    // MARK: - Property
    let uiLayer = UILayer()
    private var window: UIWindow?
}

extension CPBootService {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        uiLayer.startUI()
        
        return true
    }
}
