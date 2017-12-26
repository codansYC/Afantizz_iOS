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
import RxSwift
import RxCocoa

class PagingController<T: HandyJSON>: TableController {
    
    var pagingVM: PagingViewModel<T>? {
        didSet{
            setUpPagingVMEvent()
        }
    }
    
    var header: MJRefreshNormalHeader?
    var footer: MJRefreshBackNormalFooter?
    
    var isAllowPullDown: Bool = true {
        willSet{
            if newValue != isAllowPullDown {
                tableView.mj_header = newValue ? header : nil
            }
        }
    }
    
    var isAllowPullUp: Bool = true {
        willSet{
            if newValue != isAllowPullDown {
                tableView.mj_footer = newValue ? footer : nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isShowLodingView = true
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.pagingVM?.pullDownRefresh()
        })
        header?.stateLabel.isHidden = true
        tableView.mj_header = header
        
        footer = MJRefreshBackNormalFooter.init { [unowned self] in
            self.pagingVM?.pullUpLoadMore()
        }
        footer?.stateLabel.text = "上拉加载更多"
        footer?.setTitle("—— 好,就到这儿了 ——", for: .noMoreData)
        footer?.setTitle("上拉加载更多", for: .idle)
        footer?.setTitle("松开立即加载", for: .pulling)
        footer?.setTitle("正在加载更多数据...", for: .refreshing)
        footer?.stateLabel.textColor = UIColor.hx596167
        footer?.stateLabel.font = UIFont.systemFont(ofSize: 14)
        tableView.mj_footer = footer
    }
    
    func setUpPagingVMEvent() {
        guard let pagingVM = pagingVM  else {
            return
        }
        //控制loading页的显隐以及tableView的上下拉
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
            case .error(_, let errMsg):
                HUDManager.show(message: errMsg, in: self.view, autoHideDelay: 1)
                self.tableView.mj_footer?.endRefreshing()
            }
            self.tableView.mj_header.endRefreshing()
            if self.isShowLodingView {
                self.isShowLodingView = false
            }
        }).disposed(by: disposeBag)
        
        //控制errorBackgroudView的UI
        
        errBgDisposeBag = DisposeBag()
        pagingVM.loadDataStatus.asObservable()
            .share(replay: 1)
            .takeUntil(pagingVM.rx.deallocated)
            .bind { [unowned self] (status) in
            switch status {
            case .none:
                break
            case .noData:
                self.errorBackgroudView.show(view: self.view, style: .noData)
            case .error(let errCode, _) where errCode == BizConsts.networkPoorCode:
                self.errorBackgroudView.show(view: self.view, style: .noWifi, buttonClick: pagingVM.pullDownRefresh)
            default:
                self.errorBackgroudView.errorStyle.value = .noError
                self.errBgDisposeBag = nil
            }
            }.disposed(by: errBgDisposeBag!)
    }
}
