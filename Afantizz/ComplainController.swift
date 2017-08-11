//
//  ComplainController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore
import MBProgressHUD

class ComplainController: WebViewController, jSComplain {
    

    var jsContext: JSContext?
    
    var complainLoadingHud: MBProgressHUD?
    
    var urlStr: String? = "" {
        didSet{
            self.url = URL(string: urlStr ?? "http") ?? URL(string: "http")
            self.loadWebPage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "举报"
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext

        self.jsContext = context
        self.jsContext?.setObject(self, forKeyedSubscript: "JSInteraction" as (NSCopying & NSObjectProtocol))
    }
    
    func showLoadingWhileComplain() {
        DispatchQueue.main.async {
            self.complainLoadingHud = HUDManager.showLoading()
        }
    }
    
    func removeLoadingComplainDone() {
        DispatchQueue.main.async {
            self.complainLoadingHud?.hide(animated: true)
        }
    }
    
    func back() {
        self.navigationController?.popViewController(animated: true)
    }


}


@objc protocol jSComplain: JSExport {
    
    func showLoadingWhileComplain()
    
    func removeLoadingComplainDone()
    
    func back()
}
