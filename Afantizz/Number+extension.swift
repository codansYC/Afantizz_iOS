//
//  Number+extension.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/28.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

extension Double {
    var layout: CGFloat {
        return  Screen.width / Screen.width_iPhone6 * CGFloat(self)
    }
}

extension Int {
    var layout: CGFloat {
        return  Screen.width / Screen.width_iPhone6 * CGFloat(self)
    }
}

extension CGFloat {
    var layout: CGFloat {
        return  Screen.width / Screen.width_iPhone6 * self
    }
}
