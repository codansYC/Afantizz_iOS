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
import MBProgressHUD

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
    
    
    // 界面上的hud
    var hud: CMBProgressHUD?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationController?.setBarBackgroundColor(UIColor.navBarColor)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func showLoadingView(show: Bool) {
        if show {
            if loadingView.superview == self {
                return
            } else {
                loadingView.removeFromSuperview()
                view.addSubview(loadingView)
                loadingView.layer.zPosition = UIViewLevel.Loading
                loadingView.snp.makeConstraints({ (make) in
                    make.edges.equalTo(view)
                })
            }
        } else {
            loadingView.removeFromSuperview()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension BaseController {
    func showLoading(_ msg: String? = nil) {
        self.hud = HUDManager.showLoading(message: msg)
    }
    
    func show(_ message: String, autoHideDelay: TimeInterval = 1, completion: (()->Void)? = nil) {
        self.hud = HUDManager.show(message: message, in: view, autoHideDelay: autoHideDelay, completion: completion)
    }
    
    func showNetWorkError() {
        self.hud = HUDManager.showNetworkError(in: view)
    }
    
    func hideHud(animated: Bool = true, afterDelay: TimeInterval = 0, completion: (()->Void)? = nil) {
        self.hud?.hide(animated: animated, afterDelay: afterDelay)
        if let _completion = completion {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+afterDelay, execute: _completion)
        }
    }
    
    func resetHud(mode: MBProgressHUDMode, text: String, detail: String? = nil) {
        guard let _hud = hud else {
            return
        }
    
        _hud.mode = mode
        _hud.label.text = text
        if let _detail = detail {
            _hud.detailsLabel.text = _detail
        }
        
        let anim = CATransition()
        anim.type = kCATransitionFade
        anim.duration = 0.2
        _hud.layer.add(anim, forKey: nil)
        
    }
    
}

