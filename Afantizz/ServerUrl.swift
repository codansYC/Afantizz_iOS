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
    /**用户信息*/
    static let userInfo = "user/info"
    /**发布房源的的html文件*/
    static let ReleaseH5 = "m_release.html"
    /**房源详情的的html文件*/
    static func HouseDetailH5(houseId: String) -> String {
        var urlStr = basicUrl + "m/m_detail.html?house_id=" + houseId
        if let token = Global.token {
            urlStr += "&token=\(token)"
        }
        return urlStr
    }
    /**举报房源的html文件*/
    static func ComplainH5(houseId: String) -> String {
        var urlStr = basicUrl + "m/m_complain.html?house_id=" + houseId
        if let token = Global.token {
            urlStr += "&token=\(token)"
        }
        return urlStr
    }
    /**我的发布的html文件*/
    static func myReleaseH5() -> String {
        let urlStr = basicUrl + "m/m_myRelease.html?token=" + (Global.token ?? "")
        return urlStr
    }
    /**我的发布的html文件*/
    static func myCollectionH5() -> String {
        let urlStr = basicUrl + "m/m_myCollection.html?token=" + (Global.token ?? "")
        return urlStr
    }
    /**我的发布的html文件*/
    static func feedbackH5() -> String {
        var urlStr = basicUrl + "m/m_feedback.html?"
        if let token = Global.token {
            urlStr += "&token=\(token)"
        }
        return urlStr
    }
    
}

extension String {
    func toUrl() -> String {
        return ServerUrl.basicUrl + self
    }
    func toMobileWeb() -> String {
        return ServerUrl.basicUrl + "m/" + self
    }
}
