//
//  FilterCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    var item: String = "" {
        didSet{
            titleLabel.text = item
        }
    }
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.hx333
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
