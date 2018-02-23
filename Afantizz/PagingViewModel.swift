//
//  PagingViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import HandyJSON
import RxSwift
import RxCocoa

class PagingViewModel<T: BaseModel>: ListViewModel<T> {
    
    var currentPage = 1
    
    override func pullDownRefresh() {
        currentPage = 1
        requestData()
    }
    
    func pullUpLoadMore() {
        currentPage += 1
        requestData()
    }
    
    func requestData() {
        willSendRequest()
        params["page"] = self.currentPage
        [T].request(url: pullUrl, params: params, success: { [weak self] (obj) in
            self?.handleNewData(data: obj)
        }, error: { [weak self] (err) in
            guard let this = self else { return }
            this.loadDataStatus.value = .error(err)
            this.currentPage = max(this.currentPage-1, 1)
            }, networkError: { [weak self] in
                guard let this = self else { return }
                this.loadDataStatus.value = .error(AfantizzError(code: BizConsts.networkPoorCode, msg: BizConsts.networkPoorMsg))
                this.currentPage = max(this.currentPage-1, 1)
        })
        didSendRequest()
    }
    
    func handleNewData(data:[T?]?) {
        if currentPage == 1 {
            loadDataStatus.value = .pullDownDone
            listSource.value.removeAll()
            if data?.isEmpty != false {
                loadDataStatus.value = .noData
            }
        } else {
            if data?.isEmpty == false {
                loadDataStatus.value = .pullDownDone
            } else {
                loadDataStatus.value = .noMore
            }
        }
        listSource.value += (data ?? [T?]())
    }
}

// 加载数据的状态
enum LoadDataStatus {
    case none
    case noData
    case pullDownDone
    case pullUpDone
    case noMore
    case error(AfantizzError)
}
