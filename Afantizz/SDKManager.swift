//
//  SDKManager.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/29.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

struct SDKManager {
    
   static func configure(options: [UIApplicationLaunchOptionsKey: Any]?) {
        // 键盘监听
        IQKeyboardManager.sharedManager().shouldResignOnTouchOutside = true
        IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
        
        // 向微信注册
        WXApi.registerApp(App.Wechat.AppID)
    }
    
    

}
