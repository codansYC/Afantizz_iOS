//
//  String+extension.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/31.
//  Copyright © 2018年 lekuai. All rights reserved.
//

extension String {
    
}

extension Optional where Wrapped == String {
    var wrapSafely: String {
        return self ?? ""
    }
}
