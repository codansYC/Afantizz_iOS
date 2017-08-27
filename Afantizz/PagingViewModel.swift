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

class PagingViewModel<T:HandyJSON>: BaseViewModel {
    
    var currentPage = 1
    var pullUrl = ""
    /** 除分页外的所有参数 */
    var params = [String : Any]()
    var listSource = Variable([T?]())
    
    init(pullUrl: String) {
        super.init()
        self.pullUrl = pullUrl
    }
    
    init(pullUrl: String, params: [String : Any]) {
        super.init()
        self.pullUrl = pullUrl
        self.params = params
    }
    
    func pullDownRefresh() {
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
        Networker.request(url: pullUrl, params: params, success: { [weak self] (jsonStr) in
            let newData = [T].deserialize(from: jsonStr)
            self?.handleNewData(data: newData)
            }, error: { [weak self] (errCode, errMsg) in
                guard let this = self else { return }
                this.loadDataStatus.value = .error(errCode: errCode, errMsg: errMsg)
                this.currentPage = max(this.currentPage-1, 1)
            }, networkError: { [weak self] in
                guard let this = self else { return }
                this.loadDataStatus.value = .error(errCode: BizConsts.networkPoorCode, errMsg: BizConsts.networkPoorMsg)
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
    
    func willSendRequest() {
        
    }
    
    func didSendRequest() {
        
    }
   

}

// 加载数据的状态
enum LoadDataStatus {
    case none
    case noData
    case pullDownDone
    case pullUpDone
    case noMore
    case error(errCode: Int, errMsg: String)
}
