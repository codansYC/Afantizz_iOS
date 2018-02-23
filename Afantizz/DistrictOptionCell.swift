//
//  OptionCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class DistrictOptionCell: UICollectionViewCell {
    
    var district: District! {
        didSet{
            titleLabel.text = district?.district_name
        }
    }

    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    override var isSelected: Bool {
        didSet{
            titleLabel.textColor = isSelected ? UIColor.hx34c86c : UIColor.hx333
        }
    }
}
