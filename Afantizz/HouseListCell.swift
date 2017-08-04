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
    
    var house: House! {
        didSet{
            if !house.images.isEmpty {
                let url = URL(string: ServerUrl.basicUrl + house.images[0])
                imageV.sd_setImage(with: url)
            }
            titleLabel.text = house.title
            addressLabel.text = house.district + "-" + house.address
            priceLabel.text = "¥" + house.price
            dateLabel.text = house.date
            trafficLabel.text = house.traffic
        }
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(imageV)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(trafficLabel)
        
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
            make.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(imageV)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(priceLabel)
            make.right.equalTo(titleLabel)
        }
        trafficLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageV)
            make.right.equalTo(titleLabel)
            make.top.equalTo(imageV.snp.bottom).offset(10)
        }
        let line = UIView()
        addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.right.equalTo(trafficLabel)
            make.top.equalTo(trafficLabel.snp.bottom).offset(10)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
