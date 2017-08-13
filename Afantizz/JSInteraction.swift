//
//  JSInteraction.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore
import MBProgressHUD

@objc class JSInteraction: NSObject, JavaScriptSwiftDelegate {
    
    weak var jsContext: JSContext?
    var releaseLoadingHud: MBProgressHUD?
    
    var complainPageUrlStr: String?
    
    //MARK: - 发布操作
    func showLoadingWhileReleasing() {
        DispatchQueue.main.async {
            self.releaseLoadingHud = HUDManager.showLoading()
        }
    }
    
    func removeLoadingReleaseDone() {
        DispatchQueue.main.async {
            self.releaseLoadingHud?.hide(animated: true)
        }
    }
    
    func turnToHouseListPageAfterReleaseSuccess() {
        DispatchQueue.main.async {
            let tabBarVC = Global.appDelegate.tabBarVC
            tabBarVC?.selectedIndex = 0
        }
    }
    
    //MARK: - 房源详情
    func getAppToken() -> String {
        if let token = Global.token {
            return token
        }
        DispatchQueue.main.async {
            let loginNaviVC = NavigationController(rootViewController: LoginController())
            UIViewController.getCurrentController()?.present(loginNaviVC, animated: true, completion: nil)
        }
        return ""
    }
    
    //MARK: - 举报
    func turnToComplainPage() {
        DispatchQueue.main.async {
            guard let urlStr = self.complainPageUrlStr else {
                return
            }
            let complainVC = ComplainController(URLStr: urlStr)
            UIViewController.getCurrentController()?.navigationController?.pushViewController(complainVC, animated: true)
        }
    }
    
}


@objc protocol JavaScriptSwiftDelegate: JSExport {
    
    
    //MARK: - 发布操作
    
    func showLoadingWhileReleasing()
    
    func removeLoadingReleaseDone()
    
    func turnToHouseListPageAfterReleaseSuccess()
    
    //MARK: - 房源详情
    
    func getAppToken() -> String
    
    //MARK: - 举报
    func turnToComplainPage()
    
}
