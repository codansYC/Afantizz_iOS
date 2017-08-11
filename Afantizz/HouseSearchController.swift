//
//  MessageSearchController.swift
//  LikingManager
//
//  Created by lekuai on 17/3/24.
//  Copyright © 2017年 LikingFit. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HouseSearchController: TableController {

    var searchV: CustomSearchView!
    
    let reuseIdentifier = "HouseListCell"

    var searchEmptyView: ErrorBackgroundView!
    
    let viewModel = HouseSearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parent?.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.setStatusBarStyle(.default, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchV.searchBar.becomeFirstResponder()
    }
    
    func setUpViews() {
        searchV = CustomSearchView(frame: CGRect.init(x: 0, y: 0, width: Global.ScreenWidth, height: 50))
        searchV.backgroundColor = UIColor.hxf5f5f5
        searchV.isHidSystemBorder = true
        searchV.fieldHeight = 35
        searchV.invokerNaviVC = parent?.navigationController
        
        view.addSubview(searchV)
        let cancelBtn = searchV.cancelBtn
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.hx4e4e4e, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        let searchBar = searchV.searchBar
        searchBar?.placeholder = "请输入关键字"
        
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(searchV.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }

        searchEmptyView = ErrorBackgroundView()
        searchEmptyView.img = UIImage(named: "error-no-data")
        searchEmptyView.desc = "没有搜索到结果"
        searchEmptyView.errorStyle.value = .noData
        view.addSubview(searchEmptyView)
        searchEmptyView.snp.makeConstraints { (make) in
            make.right.bottom.left.equalTo(view)
            make.top.equalTo(tableView.snp.top)
        }
        
    }
    
    var isFirst = true
    func setUpEvents() {
        searchV.activeState.asObservable().bind { [unowned self] (isActive) in
            if !isActive && !self.isFirst {
                self.tabBarController?.tabBar.isHidden = false
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
            }
            self.isFirst = false
        }.addDisposableTo(disposeBag)
        
        searchV.searchBtnClick = { [unowned self] searchV in
            searchV.searchBar.resignFirstResponder()
            let kw = searchV.searchBar.text
            let result = self.viewModel.validKeyword(kw)
            if !result.0 {
                HUDManager.show(message: result.1, in: self.view)
                return
            }
            self.viewModel.search(kw!)
        }
        
        viewModel.searchResult.asObservable().bind(to: self.tableView.rx.items(cellIdentifier: self.reuseIdentifier, cellType: HouseListCell.self)) {
                row, model, cell in
                cell.house = model
        }.addDisposableTo(self.disposeBag)
        viewModel.searchResult.asObservable().bind { (houses) in
            self.searchEmptyView.isHidden = !houses.isEmpty
        }.addDisposableTo(disposeBag)

        tableView.rx.modelSelected(House.self).bind { (house) in
            print(house.house_id)
        }.addDisposableTo(disposeBag)
        
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        tableView.register(HouseListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.keyboardDismissMode = .onDrag
    }
    
}