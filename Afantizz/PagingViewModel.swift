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
    var params = [String : Any]()
    var listSource = Variable([T?]())
    var loadDataStatus = Variable(LoadDataStatus.none)
    
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
        params["page"] = currentPage
        Networker.request(url: pullUrl, params: params, success: { (jsonStr) in
            let newData = [T].deserialize(from: jsonStr)
            self.handleNewData(data: newData)
        }, error: { (errCode, errMsg) in
            self.loadDataStatus.value = .error(errMsg: errMsg)
        })
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
    case error(errMsg: String)
}
