//
//  AppDelegate.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: CPDelegate {

    override func services() -> [CPAppService] {
        return [

            CPBootService(with: window)             /* UI入口 */
        ]
    }
}

