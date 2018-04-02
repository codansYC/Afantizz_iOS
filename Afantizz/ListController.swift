//
//  ListController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift

class ListController<M, VM: ListViewModel<M>>: TableController<VM> {
    
    var mj_header: MJRefreshNormalHeader?
    
    var isAllowPullDown: Bool = true {
        willSet{
            if newValue != isAllowPullDown {
                tableView.mj_header = newValue ? mj_header : nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showLoading()
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        mj_header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.viewModel.pullDownRefresh()
        })
        mj_header?.stateLabel.isHidden = true
        tableView.mj_header = mj_header
    }

    
}

