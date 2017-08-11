//
//  JSInteraction.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore

@objc class JSInteraction: NSObject, JavaScriptSwiftDelegate {
    
    weak var jsContext: JSContext?
    
    func releaseSuccess() {
        print("发布成功")
    }
    
    func showLoadingWhileReleasing() {
        HUDManager.showLoading()
    }
}


@objc protocol JavaScriptSwiftDelegate: JSExport {
    
    func releaseSuccess()
    
    // 发布中状态显示loading
    func showLoadingWhileReleasing()
    
}
