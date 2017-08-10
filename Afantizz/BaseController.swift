//
//  BaseController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseController: UIViewController {
    
    lazy var disposeBag: DisposeBag = DisposeBag()
    
    // loading页
    let loadingView = LoadingBackgroundView()
    var isShowLodingView = false {
        didSet{
            showLoadingView(show: isShowLodingView)
        }
    }
    
    // error页
    let errorBackgroudView = ErrorBackgroundView()
    
    var errBgDisposeBag: DisposeBag?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    func showLoadingView(show: Bool) {
        if show {
            if loadingView.superview == self {
                return
            } else {
                loadingView.removeFromSuperview()
                view.addSubview(loadingView)
                loadingView.layer.zPosition = 1
                loadingView.snp.makeConstraints({ (make) in
                    make.edges.equalTo(view)
                })
            }
        } else {
            loadingView.removeFromSuperview()
        }
    }
    
}
