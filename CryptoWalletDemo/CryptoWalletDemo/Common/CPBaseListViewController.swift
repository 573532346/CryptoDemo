//
//  CPBaseListViewController.swift
//  CryptoWalletDemo
//
//  Created by Dennis.zhang on 2020/8/26.
//  Copyright © 2020 蓝猫. All rights reserved.
//

import UIKit
import SnapKit

//(cellId, cell height, cell config data, cell click action)
typealias CPCellItem = (String, CGFloat?, Any?, ((IndexPath) -> Void)?)
typealias CPCellItems = [CPCellItem]


protocol YFListCellProtocol {
    func refresh(_ data: Any?)
}

class CPBaseListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        registerTableViewCells()
        setupSubviews()
    }
    
    private func registerTableViewCells() {
        for item in registerCells() {
            if let cellClass = item.0 as? UITableViewCell.Type {
                tableView.register(cellClass, forCellReuseIdentifier: item.1)
            }
            if let cellNibName = item.0 as? String {
                tableView.register(UINib.init(nibName: cellNibName, bundle: nil), forCellReuseIdentifier: item.1)
            }
        }
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.size.equalToSuperview()
        }
    }
    
    
    func refreshUI() {
        listData = makeDisplayItems()
        tableView.reloadData()
    }
    
    //MARK: for sub class
    func makeDisplayItems() -> [[CPCellItem]] {
        return []
    }
    
    //需要注册的cell,子类覆盖，any为UITableViewCell.type或string(nib名称)
    func registerCells() -> [(Any, String)] {
        return []
    }
    
    func configDividerLines(_ lineCell: CPBaseListViewCell, _ indexPath: IndexPath) {
        //子类实现
    }
    
    //MARK: helper
    func rowItemAt(_ indexPath: IndexPath) -> CPCellItem {
        let sectionArray = sectionArrayAt(indexPath.section)
        guard indexPath.row < sectionArray.count else {
            return CPCellItem("", nil, nil, nil)
        }
        return sectionArray[indexPath.row]
    }
    
    func sectionArrayAt(_ section: Int) -> [CPCellItem] {
        guard section < listData.count else {
            return [CPCellItem]()
        }
        return listData[section]
    }
    
    func reloadVisiableCells() {
        if let visiableIndexPaths = tableView.indexPathsForVisibleRows {
            tableView.reloadRows(at: visiableIndexPaths, with: .none)
        }
    }
    
    //MARK: property
    var listData: [[CPCellItem]] = []
    
    var tableStyle: UITableView.Style {
        return .grouped
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(), style: self.tableStyle)
        table.delegate = self
        table.dataSource = self
        table.estimatedRowHeight = 50
        table.backgroundColor = .white
        table.separatorStyle = .none
        return table
    }()


}

extension CPBaseListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionArray = sectionArrayAt(section)
        return sectionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //(cellId, cell height, cell config data, cell click action)
        let item = rowItemAt(indexPath)
        return item.1 != nil ? item.1! : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = rowItemAt(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.0)
        
        if let mineCell = cell as? YFListCellProtocol {
            mineCell.refresh(item.2)
        }
        
        if let lineCell = cell as? CPBaseListViewCell {
            configDividerLines(lineCell, indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = rowItemAt(indexPath)
        item.3?(indexPath)
    }
}

