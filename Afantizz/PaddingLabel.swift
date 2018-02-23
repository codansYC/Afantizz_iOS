//
//  PaddingLabel.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/31.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    
    var padding = UIEdgeInsets.zero
    
    init(_ padding: UIEdgeInsets) {
        super.init(frame: .zero)
        self.padding = padding
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRect(forBounds: UIEdgeInsetsInsetRect(bounds, padding), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= padding.left
        rect.origin.y -= padding.top
        rect.size.width += padding.left + padding.right
        rect.size.height += padding.top + padding.bottom
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }
}
