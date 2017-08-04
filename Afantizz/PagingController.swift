//
//  PagingController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import MJRefresh
import HandyJSON

class PagingController<T: HandyJSON>: BaseController {
    
    var tableView: UITableView!
    var pagingVM: PagingViewModel<T>? {
        didSet{
            setUpPagingVMEvent()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        isShowLodingView = true
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        // header
        let header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.pagingVM?.pullDownRefresh()
        })
        header?.stateLabel.isHidden = true
        tableView.mj_header = header
        
        // footer
        let footer = MJRefreshBackNormalFooter.init { [unowned self] in
            self.pagingVM?.pullUpLoadMore()
        }
        footer?.stateLabel.text = "上拉加载更多"
        footer?.setTitle("—— 好,就到这儿了 ——", for: .noMoreData)
        footer?.setTitle("上拉加载更多", for: .idle)
        footer?.setTitle("松开立即加载", for: .pulling)
        footer?.setTitle("正在加载更多数据...", for: .refreshing)
        footer?.stateLabel.textColor = UIColor.hx596167
        footer?.stateLabel.font = UIFont.systemFont(ofSize: 14)
        footer?.isAutomaticallyHidden = true
        tableView.mj_footer = footer
    }
    
    func setUpPagingVMEvent() {
        guard let pagingVM = pagingVM  else {
            return
        }
        pagingVM.loadDataStatus.asObservable()
            .takeUntil(pagingVM.rx.deallocated)
            .bind(onNext: { [unowned self] (status) in
            switch status {
            case .none:
                return
            case .pullDownDone:
                self.tableView.mj_footer?.resetNoMoreData()
                self.tableView.mj_footer?.endRefreshing()
            case .pullUpDone:
                self.tableView.mj_footer?.endRefreshing()
            case .noData:
                self.tableView.mj_footer?.endRefreshing()
            case .noMore:
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            case .error(let errMsg):
                print(errMsg)
            }
            self.tableView.mj_header.endRefreshing()
            if self.isShowLodingView {
                self.isShowLodingView = false
            }
            
        }).addDisposableTo(disposeBag)
    }
}
