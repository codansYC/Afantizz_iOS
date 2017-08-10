//
//  ReleaseController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/9.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class ReleaseController: WebViewController {

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
        
        title = "发布房源"
    }
}
