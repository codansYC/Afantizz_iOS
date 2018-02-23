//
//  AfantizzError.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/24.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import Foundation

struct AfantizzError {
    var code: Int
    var msg: String
    
    static let networkError = AfantizzError(code: -1009, msg: "网络异常")
}
