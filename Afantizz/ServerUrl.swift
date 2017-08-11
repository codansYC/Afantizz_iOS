//
//  ServerUrl.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class ServerUrl: NSObject {
    
    /**基地址*/
    static let basicUrl = "http://afantizz.com/"
    /**房源列表*/
    static let houseList = "house/list"
    /**房源详情*/
    static let houseDetail = "house/detail"
    /**房源详情*/
    static let houseSearch = "house/search"
    /**获取验证码*/
    static let GetCaptcha = "login/captcha"
    /**登录*/
    static let Login = "login/login"
    /**发布房源的的html文件*/
    static let ReleaseH5 = "m_release.html"
}

extension String {
    func toUrl() -> String {
        return ServerUrl.basicUrl + self
    }
    func toMobileWeb() -> String {
        return ServerUrl.basicUrl + "m/" + self
    }
}