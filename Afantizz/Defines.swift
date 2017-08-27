//
//  Defines.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/16.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

// MARK: - 全局方法
// MARK: log
func debugPrint(items: Any...) {
    #if DEBUG
        print(items)
    #endif
}

func debugLog(_ message: Any, filename: String = #file, function: String = #function, line: Int = #line) {
    #if DEBUG
        print("[\(NSURL(string: filename)?.lastPathComponent ?? ""):\(line)] \(function) - \(message)")
    #endif
}

func debugAlert(items: Any...) {
    #if DEBUG
        let desc = items.map({ (msg) -> String in
            return String(describing: msg)
        }).joined(separator: ",")
        UIViewController.getCurrentController()?.show(message: desc)
    #endif
}

struct UIViewLevel {
    static let normal: CGFloat = 0
    static let Loading: CGFloat = 1
    static let hud: CGFloat = 2
}
