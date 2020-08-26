//
//  CPDelegate.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

@_exported import UIKit

class CPDelegate: UIResponder, UIApplicationDelegate {

    open func services() -> [CPAppService] {
        return [ /* 子类提供 */ ]
    }
    
    // MARK: - Property - UI
    public var window: UIWindow?
    
    
    // MARK: - Property
    public lazy var lazyServices: [CPAppService] = {
        services()
    }()
}


extension CPDelegate {
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return lazyServices.reduce(true) {
            $0 && $1.application(application, willFinishLaunchingWithOptions: launchOptions)
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return lazyServices.reduce(true) {
            $0 && $1.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    }
}
