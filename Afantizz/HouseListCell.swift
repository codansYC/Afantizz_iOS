//
//  HouseListCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class HouseListCell: UITableViewCell {
    
    let imageV = UIImageView()
    let titleLabel = UILabel()
    let addressLabel = UILabel()
    let priceLabel = UILabel()
    let dateLabel = UILabel()
    let trafficLabel = UILabel()
    let rentModeLabel = UILabel()
    let gprsIcon = UIImage(named: "icon-gprs")
    let gprsSign = UIView()
    
    var house: House? {
        didSet{
            guard let house = house else {
                return
            } 
            if !house.images.isEmpty {
                let url = URL(string: ServerUrl.basicUrl + house.images[0])
                imageV.sd_setImage(with: url)
            }
            titleLabel.text = house.title
            addressLabel.text = house.district + "-" + house.address
            priceLabel.text = "¥" + house.price
            dateLabel.text = house.date
            trafficLabel.text = house.traffic
            rentModeLabel.text = house.rent_mode
        }
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addressLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor.priceColor
        trafficLabel.font = UIFont.systemFont(ofSize: 12)
        trafficLabel.textColor = UIColor.hx888b9a
        rentModeLabel.font = UIFont.systemFont(ofSize: 13)
        rentModeLabel.textColor = UIColor.hx337ab7
        rentModeLabel.backgroundColor = UIColor.hx337ab7.withAlphaComponent(0.2)
        gprsSign.backgroundColor = UIColor.hx888b9a
        gprsSign.mask = UIImageView(image: gprsIcon)
        
        addSubview(imageV)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(gprsSign)
        addSubview(trafficLabel)
        addSubview(rentModeLabel)
        
        imageV.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.size.equalTo(CGSize.init(width: 100, height: 75))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageV)
            make.left.equalTo(imageV.snp.right).offset(10)
            make.right.equalTo(-15)
        }
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.right.equalTo(rentModeLabel.snp.left).offset(-10)
        }
        rentModeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel)
            make.centerY.equalTo(addressLabel)
        }
        addressLabel.setContentCompressionResistancePriority(100, for: .horizontal)
        rentModeLabel.setContentHuggingPriority(900, for: .horizontal)
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(imageV)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(priceLabel)
            make.right.equalTo(titleLabel)
        }
        gprsSign.snp.makeConstraints { (make) in
            make.left.equalTo(imageV)
            make.top.equalTo(imageV.snp.bottom).offset(10)
            make.size.equalTo(gprsIcon!.size)
        }
        trafficLabel.snp.makeConstraints { (make) in
            make.left.equalTo(gprsSign.snp.right).offset(5)
            make.right.equalTo(titleLabel)
            make.centerY.equalTo(gprsSign)
        }
        let line = UIView()
        addSubview(line)
        line.backgroundColor = UIColor.colorWithHex(hex: 0xedeff3)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(imageV)
            make.top.equalTo(trafficLabel.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.right.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
