//
//  Number+extension.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/28.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

extension SignedNumber {
    var layout: CGFloat {
        if let number = self as? NSNumber {
            return  Screen.width / Screen.width_iPhone6 * CGFloat(number)
        }
        return CGFloat(0)
    }
}

extension CGFloat {
    var layout: CGFloat {
        return  Screen.width / Screen.width_iPhone6 * self
    }
}
