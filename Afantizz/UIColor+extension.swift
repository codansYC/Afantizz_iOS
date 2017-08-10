//
//  UIColor+extension.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/10.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func colorWithHex(hex: Int) -> UIColor {
        return UIColor(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func colorWithRGB(r: Int, g: Int, b: Int) -> UIColor {
            return UIColor(red: CGFloat(r) / 255.0,
                           green: CGFloat(g) / 255.0,
                           blue: CGFloat(b) / 255.0,
                           alpha: 1)
    }
    
    //导航栏颜色
    class var navBarColor: UIColor {
        return UIColor.colorWithHex(hex: 0x337ab7)
    }
    
    //
    class var hx337ab7: UIColor {
        return UIColor.colorWithHex(hex: 0x337ab7)
    }
    
    //常用的绿色
    class var hx34c86c: UIColor {
        return UIColor.colorWithHex(hex: 0x34c86c)
    }
    
    //
    class var hx888b9a: UIColor {
        return UIColor.colorWithHex(hex: 0x888b9a)
    }
    
    class var hx596167: UIColor {
        return UIColor.colorWithHex(hex: 0x596167)
    }
    
    class var hxf5f5f5: UIColor {
        return UIColor.colorWithHex(hex: 0xf5f5f5)
    }
    
    class var hxedeff3: UIColor {
        return UIColor.colorWithHex(hex: 0xedeff3)
    }
    
    class var hx4e4e4e: UIColor {
        return UIColor.colorWithHex(hex: 0x4e4e4e)
    }
    
}
