//
//  UILayer.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit

class UILayer: NSObject {
    

    override init() {
        super.init()

    }
    
    //MARK: Open Method
    func startUI() {
    
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootVC = UITestViewController()
        let navi = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navi
        window.makeKeyAndVisible()
        
        mainWindow = window
    }
    
    
    //MARK: Property
    var mainWindow: UIWindow?
    
}
