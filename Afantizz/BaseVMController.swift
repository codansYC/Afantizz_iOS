//
//  BaseVMController.swift
//  Afantizz
//
//  Created by yuanchao on 2018/3/5.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class BaseVMController<VM: BaseViewModel>: BaseController, ViewModelProtocol {

    var viewModel: VM! {
        didSet{
            if viewModel == nil {
                return
            }
            setUpViewModelBinding()
        }
    }
    
    func setUpViewModelBinding() {
        bindRequestError()
    }
    
    func bindRequestError() {
        
        viewModel.requestError.asObservable().takeUntil(viewModel.rx.deallocating).bind { (error) in
            guard let error = error else {
                self.hud?.hide(animated: true)
                return
            }
            self.resetHud(mode: .text, text: error.msg)
            self.hideHud(afterDelay: 1)
            }.disposed(by: disposeBag)
    }
}
