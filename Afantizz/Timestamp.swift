//
//  TimeStamp.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/17.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit
import HandyJSON

struct Timestamp: HandyJSON {
    var reqTime = 0
    var respTime = 0
    var serverTime = 0
    /** 时间差值 */
    var timeDelta: Int {
        return (respTime - reqTime) / 2 + serverTime - respTime // 服务器时间戳 - 响应时本地时间
    }
    /**
     获取时间戳，服务器当前时间
     */
    var serverCurrentTimestamp: Int {
        return Int(Date().timeIntervalSince1970) + timeDelta
    }
}
