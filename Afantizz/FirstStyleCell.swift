//
//  StyleCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class FirstStyleCell: BaseTableViewCell {
    
    var item: String = "" {
        didSet{
            titleLabel.text = item
        }
    }

    var titleLabel: UILabel!
    var arrow: BaseView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.hx596167
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.right.equalTo(self.snp.centerX).offset(-10)
        }
        
        arrow = BaseView()
        arrow.backgroundColor = UIColor.hx333
        addSubview(arrow)
        let img = UIImage(named: "right-arrow")
        let imgV = UIImageView(image: img)
        arrow.mask = imgV
        arrow.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.centerX).offset(10)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(img!.size)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        titleLabel.textColor = selected ? UIColor.hx34c86c : UIColor.hx333
        arrow.backgroundColor = selected ? UIColor.hx34c86c : UIColor.hx596167
    }
}
