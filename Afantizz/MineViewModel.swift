//
//  MineViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class MineViewModel: BaseViewModel {
    weak var mineVC: UIViewController? {
        return (Global.appDelegate.tabBarVC?.childViewControllers[2] as? NavigationController)?.topViewController
    }
    var loginState = Variable(Global.isLogin)
    
    func getUserInfoIfLogin() {
        guard let token = Global.token else {
            loginState.value = false
            return
        }
        loginState.value = true
        let params: [String: Any] = ["token": token]
        User.request(url: ServerUrl.userInfo, params: params, success: { (user) in
            if let user = user, !user.phone.isEmpty {
                Global.user = user
            } else {
                Global.user = nil
            }
            self.loginState.value = Global.user != nil
        }, error: { [weak self] (err) in
            self?.requestError.value = err
        }) { [weak self] in
            self?.requestError.value = AfantizzError.networkError
        }
    }
    
    func alertTologOff() {
        //应该发起退出登录的请求，暂时没写
        let alertC = UIAlertController(title: nil, message: "确定要退出登录?", preferredStyle: .alert)
        alertC.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        alertC.addAction(UIAlertAction(title: "退出登录", style: .default, handler: { [unowned self] (_) in
            self.logOff()
        }))
        mineVC?.present(alertC, animated: true, completion: nil)
    }
    
    func logOff() {
        Global.clearUserInfo()
        loginState.value = false

    }
    
    func toMyReleasePageIfLogin() {
        guard Global.isLogin else {
            Global.toLoginPage()
            return
        }
        let myReleaseVC = MyReleaseController(URLStr: ServerUrl.myReleaseH5())
        mineVC?.navigationController?.pushViewController(myReleaseVC, animated: true)
    }
    
    func toMyCollectionPageIfLogin() {
        guard Global.isLogin else {
            Global.toLoginPage()
            return
        }
        let myCollectionVC = MyCollectionController(URLStr: ServerUrl.myCollectionH5())
        mineVC?.navigationController?.pushViewController(myCollectionVC, animated: true)
    }
    
    func toFeedbackPage() {
        let feedBackVC = FeedbackController(URLStr: ServerUrl.feedbackH5())
        mineVC?.navigationController?.pushViewController(feedBackVC, animated: true)
    }
 
}
