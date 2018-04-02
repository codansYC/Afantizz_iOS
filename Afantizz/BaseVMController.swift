//
//  BaseVMController.swift
//  Afantizz
//
//  Created by yuanchao on 2018/3/5.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class BaseVMController<VM: BaseViewModel>: BaseController {

    lazy var viewModel: VM = {
        let vm = VM.init()
        setUpBinding(vm)
        return vm
    }()
    
    func setUpBinding(_ viewModel: VM) {
        bindRequestError(viewModel)
    }
    
    func bindRequestError(_ viewModel: VM) {
        
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
