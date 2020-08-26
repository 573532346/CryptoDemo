//
//  CPBaseListViewCells.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//


import UIKit

class CPBaseListViewCell: UITableViewCell, YFListCellProtocol {


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews() {
        
        accessoryType = .none
        selectionStyle = .default
    }

    
    //override by sub Class
    func refresh(_ data: Any?) {
        //
    }
    
}
