//
//  HouseListController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class HouseListController: PagingController<House> {
    
    let reuseIdentifier = "HouseListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "所有房源"
        let params = ["district"  :"",
                      "subway"    :"",
                      "price"     :"",
                      "style"     :"",
                      "rent_mode" :"",
                      "sort"      :""]
        pagingVM = PagingViewModel.init(pullUrl: ServerUrl.houseList, params: params)
        pagingVM?.requestData()
                
        pagingVM?.listSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: HouseListCell.self)) { row, model, cell in
            cell.house = model
        }.addDisposableTo(disposeBag)
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        tableView.register(HouseListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        tableView.rx.modelSelected(House.self).bind { [unowned self] (house) in
            let urlStr = "http://www.afantizz.com/m/detail.html?house_id=" + house.house_id
            let webVC = WebViewController(URLStr: urlStr)
            webVC.title = "房源详情"
            webVC.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(webVC, animated: true)
        }.addDisposableTo(disposeBag)
    }
}
