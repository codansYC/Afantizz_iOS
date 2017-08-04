//
//  ListController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import MJRefresh

class ListController: TableController {
    
    var tableView: UITableView!
    var listVM: ListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        let header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.loadNewData()
        })
        header?.stateLabel.isHidden = true
        
        tableView.mj_header = header
    }
    
    func loadNewData() {
        
    }

}

//MARK: - 与ListController 对应
class ListViewModel: BaseViewModel {
    func loadNewData() {
        
    }
}


