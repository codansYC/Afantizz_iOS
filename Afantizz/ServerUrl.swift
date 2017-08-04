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
    static var basicUrl = "http://afantizz.com/"
    /**房源列表*/
    static var houseList = "house/list"
    /**房源详情*/
    static var houseDetail = "house/detail"
}

extension String {
    func toUrl() -> String {
        return ServerUrl.basicUrl + self
    }
    func toMobileWeb() -> String {
        return ServerUrl.basicUrl + "m/" + self
    }
}
