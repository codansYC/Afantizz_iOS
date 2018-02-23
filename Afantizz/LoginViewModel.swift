//
//  LoginViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/9.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewModel: BaseViewModel {
    
    var isCounting = Variable(false)
    
    func getCode(phone: String) -> Observable<Any> {
        return Observable.create({ (observer) -> Disposable in
            let params: [String: Any] = ["phone": phone]
            let hud = HUDManager.showLoading()
            Networker.request(url: ServerUrl.getCaptcha, params: params, success: { (jsonStr) in
                hud?.hide(animated: true)
                observer.onNext(true)
                observer.onCompleted()
            }, error: { (err) in
                hud?.hide(animated: true)
                observer.onCompleted()
            }, networkError: {
                hud?.hide(animated: true)
                observer.onCompleted()
            })
            return Disposables.create()
        })
        
    }
    
    func login(phone: String, code: String, success: @escaping (()->Void)) {
        let params: [String: Any] = ["phone": phone,
                                     "captcha": code,
                                     "platform": "iOS"]
        Networker.request(url: ServerUrl.Login, params: params, success: { (jsonStr) in
            Global.user = User.parase(from: jsonStr)
            UserDefaults.saveToken(Global.user?.token)
            success()
        }, error: { (err) in
            self.requestError.value = err
            }, networkError: {
               self.requestError.value = BizConsts.networkError
        })
        
    }
    
    func countDown() -> Observable<String> {
        isCounting.value = true
        let sendDate = Date()
        return Observable<Int>.timer(0, period: 1, scheduler: MainScheduler.instance).map({ (i) -> String in
            let count = 60 - Int(fabs(NSDate().timeIntervalSince(sendDate)))
            if count <= 0 {
                self.isCounting.value = false
            }
            return count > 0 ? "\(count)s" : "获取验证码"
        }).take(61)

    }

}
