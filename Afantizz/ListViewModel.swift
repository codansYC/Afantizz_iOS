//
//  ListViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/12/27.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

//MARK: - 与ListController 对应
class ListViewModel<T: BaseModel>: BaseViewModel {
    
    var pullUrl = ""
    /** 除分页外的所有参数 */
    var params = [String : Any]()
    var listSource = Variable([T?]())
    
    init(pullUrl: String, params: [String : Any] = [:]) {
        super.init()
        self.pullUrl = pullUrl
        self.params = params
    }
    
    required init() {}
    
    func pullDownRefresh() {
        willSendRequest()
        Networker.request(url: pullUrl, params: params, success: { [weak self] (jsonStr) in
            let data = [T].deserialize(from: jsonStr)
            self?.handleNewData(data)
            }, error: { [weak self] (err) in
                self?.loadDataStatus.value = .error(err)
            }, networkError: { [weak self] in
                self?.loadDataStatus.value = .error(BizConsts.networkError)
        })
        didSendRequest()
    }
    
    func handleNewData(_ data: [T?]?) {
        loadDataStatus.value = .pullDownDone
        guard let data = data, !data.isEmpty else {
            loadDataStatus.value = .noData
            return
        }
        listSource.value = data
    }
    
    func willSendRequest() {
        
    }
    
    func didSendRequest() {
        
    }
}



