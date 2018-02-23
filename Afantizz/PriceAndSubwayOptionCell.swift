//
//  PriceAndSubwayOptionCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class PriceAndSubwayOptionCell: BaseTableViewCell {
    
    var priceRange: PriceRange! {
        didSet{
            if priceRange == nil {
                return
            }
            if let minPrice = priceRange.min_price,
               let maxPrice = priceRange.max_price {
                titleLabel.text = minPrice + "-" + maxPrice
                return
            }
            if let minPrice = priceRange.min_price {
                titleLabel.text = minPrice + "以上"
            } else {
                if let maxPrice = priceRange.max_price {
                    titleLabel.text = maxPrice + "以下"
                } else {
                    titleLabel.text = Str.unlimited
                }
            }
        }
    }
    
    var item: String = "" {
        didSet{
            titleLabel.text = item
        }
    }

    var titleLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.hx596167
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.textColor = selected ? UIColor.hx34c86c : UIColor.hx333
    }
}
