//
//  ReleaseController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/9.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore

class ReleaseController: WebViewController {
    
    var jsContext: JSContext?

    var urlStr: String? = "" {
        didSet{
            self.url = URL(string: urlStr ?? "http") ?? URL(string: "http")
            self.loadWebPage()
        }
    }
    
    override init(URLStr urlStr: String? = nil) {
        super.init(URLStr: urlStr)
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "发布"
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        let m_model = JSInteraction()
        m_model.jsContext = context
        self.jsContext = context
        self.jsContext?.setObject(m_model, forKeyedSubscript: "JSInteraction" as (NSCopying & NSObjectProtocol))
    }
}
