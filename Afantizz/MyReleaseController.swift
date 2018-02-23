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
    
    func edit(_ houseId: String) {
        let urlStr = ServerUrl.releaseH5.toMobileWeb() + "?house_id=\(houseId)&token=\(Global.token ?? "")"
        let editVC = ReleaseController(URLStr: urlStr)
        editVC.title = "修改房源"
        navigationController?.pushViewController(editVC, animated: true)
    }
    

}

@objc protocol MyReleaseJsDelegate: JSExport {
    func toDetailPage(_ houseId: String)
    func edit(_ houseId: String)
}
