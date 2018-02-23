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
        (UIViewController.getCurrentController() as? BaseController)?.show(desc)
    #endif
}

struct UIViewLevel {
    static let normal: CGFloat = 0
    static let Loading: CGFloat = 1
    static let hud: CGFloat = 2
}

struct Screen {
    static let frame = UIScreen.main.applicationFrame
    static let bounds = UIScreen.main.bounds
    static let size = UIScreen.main.bounds.size
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
    static let width_iPhone4 : CGFloat = 320
    static let width_iPhone5 : CGFloat = 320
    static let width_iPhone6 : CGFloat = 375
    static let width_iPhone6p: CGFloat = 414
}

