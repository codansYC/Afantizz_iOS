//
//  ViewModelProtocol.swift
//  Afantizz
//
//  Created by yuanchao on 2018/3/29.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    associatedtype ViewModel: BaseViewModel
    var viewModel: ViewModel! { set get }
    func setUpViewModelBinding()
}

extension ViewModelProtocol {
    func setUpViewModelBinding() {
        bindRequestError()
    }
    
    func bindRequestError() {
        guard let this = self as? BaseController else {
            return
        }
        viewModel.requestError.asObservable().takeUntil(viewModel.rx.deallocating).bind { (error) in
            guard let error = error else {
                this.hud?.hide(animated: true)
                return
            }
            this.resetHud(mode: .text, text: error.msg)
            this.hideHud(afterDelay: 1)
            }.disposed(by: this.disposeBag)
    }
}



