//
//  MyReleaseController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore

class MyReleaseController: WebViewController, MyReleaseJsDelegate {
    
    var jsContext: JSContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的发布"
        
        jsContext = webView.value(forKeyPath: Str.jsContextKeyPath) as? JSContext
        jsContext?.setObject(self, forKeyedSubscript: "JSInteraction" as (NSCopying & NSObjectProtocol))
    }
    
    // MARK: - MyReleaseJsDelegate
    func toDetailPage(_ houseId: String) {
        self.toDetailVC(houseId)
    }

}

@objc protocol MyReleaseJsDelegate {
    func toDetailPage(_ houseId: String)
}
