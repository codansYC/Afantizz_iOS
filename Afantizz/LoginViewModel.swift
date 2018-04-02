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
    
    func getCode(phone: String, success: @escaping (()->Void)) {
        let params: [String: Any] = ["phone": phone]
        Networker.request(url: ServerUrl.getCaptcha, params: params, success: { (jsonStr) in
            self.requestSuccess()
            success()
        }, error: { (err) in
           self.requestFail(err)
        }, networkError: {
            self.requestFailWithNetworkPoor()
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
            self.requestFail(err)
            }, networkError: {
               self.requestFailWithNetworkPoor()
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
