//
//  App.swift
//  Afantizz
//
//  Created by yuanchao on 2017/12/27.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

struct App {
    
    static let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let name = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    static let buildVersion = Bundle.main.infoDictionary![String(kCFBundleVersionKey)] as! String
    static let platform = "iOS"
    static let key = "EqBAYzVRw2k7FswL"
}
