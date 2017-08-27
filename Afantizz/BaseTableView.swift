//
//  BaseTableView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class BaseTableView: UITableView {

    init() {
        super.init(frame: CGRect.zero, style: .plain)
        commonInit()
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        separatorStyle = .none
        showsVerticalScrollIndicator = false
    }

}
