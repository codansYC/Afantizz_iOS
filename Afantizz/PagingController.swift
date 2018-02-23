//
//  PagingController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import MJRefresh
import RxSwift
import RxCocoa

class PagingController<M, VM: PagingViewModel<M>>: ListController<M, VM> {
    
    var mj_footer: MJRefreshBackNormalFooter?
    
    var isAllowPullUp: Bool = true {
        willSet{
            if newValue != isAllowPullUp {
                tableView.mj_footer = newValue ? mj_footer : nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        mj_header?.refreshingBlock = { [unowned self] in self.viewModel?.pullDownRefresh() }
        
        mj_footer = MJRefreshBackNormalFooter.init { [unowned self] in
            self.viewModel?.pullUpLoadMore()
        }
        mj_footer?.stateLabel.text = "上拉加载更多"
        mj_footer?.setTitle("—— 好,就到这儿了 ——", for: .noMoreData)
        mj_footer?.setTitle("上拉加载更多", for: .idle)
        mj_footer?.setTitle("松开立即加载", for: .pulling)
        mj_footer?.setTitle("正在加载更多数据...", for: .refreshing)
        mj_footer?.stateLabel.textColor = UIColor.hx596167
        mj_footer?.stateLabel.font = UIFont.systemFont(ofSize: 14)
        tableView.mj_footer = mj_footer
    }
    
    override func setUpViewModelBinding() {
        super.setUpViewModelBinding()
        guard let viewModel = viewModel  else {
            return
        }
        //控制loading页的显隐以及tableView的上下拉
        viewModel.loadDataStatus.asObservable()
            .takeUntil(viewModel.rx.deallocated)
            .bind(onNext: { [unowned self] (status) in
                self.isAllowPullUp = true
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
                self.isAllowPullUp = false
            case .noMore:
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            case .error(let error):
                self.show(error.msg)
                self.tableView.mj_footer?.endRefreshing()
            }
            self.tableView.mj_header.endRefreshing()
            if self.isShowLodingView {
                self.isShowLodingView = false
            }
            }).disposed(by: disposeBag)
        
        //控制errorBackgroudView的UI
        
        errBgDisposeBag = DisposeBag()
        viewModel.loadDataStatus.asObservable()
            .share(replay: 1)
            .takeUntil(viewModel.rx.deallocated)
            .bind { [unowned self] (status) in
            switch status {
            case .none:
                break
            case .noData:
                self.errorBackgroudView.show(view: self.tableView, style: .noData)
            case .error(let error) where error.code == BizConsts.networkPoorCode:
                self.errorBackgroudView.show(view: self.tableView, style: .noWifi, buttonClick: viewModel.pullDownRefresh)
            default:
                self.errorBackgroudView.errorStyle.value = .noError
            }
            }.disposed(by: errBgDisposeBag!)
    }
}
