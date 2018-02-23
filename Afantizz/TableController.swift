//
//  TableController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class TableController<VM: BaseViewModel>: BaseController<VM> {

    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

}

