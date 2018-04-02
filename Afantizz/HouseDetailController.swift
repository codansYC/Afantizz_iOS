//
//  HouseDetailController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import JavaScriptCore

class HouseDetailController: WebViewController {
    
    var jsContext: JSContext?
    var houseId: String = ""
    var viewModel = HouseInfoViewModel()
    
    override init(URLStr urlStr: String? = nil) {
        super.init(URLStr: urlStr)
        self.hidesBottomBarWhenPushed = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "房源详情"
        viewModel.houseId = houseId
        
        let item = UIBarButtonItem()
        item.image = UIImage.init(named: "share_item")
        item.rx.tap.bind { [unowned self] in
            self.share()
        }.disposed(by: disposeBag)
        navigationItem.rightBarButtonItem = item
        
        let context = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext
        let m_model = JSInteraction()
        m_model.jsContext = context
        m_model.complainPageUrlStr = ServerUrl.complainH5(houseId: houseId)
        self.jsContext = context
        self.jsContext?.setObject(m_model, forKeyedSubscript: "JSInteraction" as (NSCopying & NSObjectProtocol))
        
        webView.dataDetectorTypes = .phoneNumber
    }
    
    func share() {
        if let configure = self.viewModel.shareConfigure {
            ShareManager.share(invoker: self, configure: configure)
            return
        }
        showLoading()
        self.viewModel.requestShareConfigure {
            self.hideHud()
            self.viewModel.shareConfigure?.webPageUrlStr = self.url.absoluteString
            if let configure = self.viewModel.shareConfigure {
                ShareManager.share(invoker: self, configure: configure)
                return
            }
        }
    }

}
