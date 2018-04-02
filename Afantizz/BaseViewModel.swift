//
//  BaseViewModel.swift
//  Afantizz
//
//  Created by yaunchao on 2017/7/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class BaseViewModel: NSObject {
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    var loadDataStatus = Variable(LoadDataStatus.none)
    var requestError: Variable<AfantizzError?> = Variable(nil)
    
    func requestSuccess() {
        requestError.value = nil
    }
    
    func requestFail(_ error: AfantizzError) {
        requestError.value = error
    }
    
    func requestFailWithNetworkPoor() {
        requestError.value = BizConsts.networkError
    }
    
}



