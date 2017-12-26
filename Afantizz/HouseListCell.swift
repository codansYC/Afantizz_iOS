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
    let tagsV = UIView()
    let bottomV = UIView()
    
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
            dateLabel.text = house.release_date
            trafficLabel.text = house.traffic
            rentModeLabel.text = house.rent_mode
            
            bottomV.snp.updateConstraints { (make) in
                make.height.equalTo(house.traffic.isEmpty ? 10 : 30)
            }
            bottomV.isHidden = house.traffic.isEmpty
            
            addTagsLabel(house: house)
        }
        
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        addressLabel.font = UIFont.systemFont(ofSize: 13)
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = UIColor.priceColor
        dateLabel.textColor = UIColor.colorWithHex(hex: 0xb3b3b3)
        dateLabel.font = UIFont.systemFont(ofSize: 12)
        trafficLabel.font = UIFont.systemFont(ofSize: 12)
        trafficLabel.textColor = UIColor.hx888b9a
        rentModeLabel.font = UIFont.systemFont(ofSize: 12)
        rentModeLabel.textColor = UIColor.hx337ab7
        rentModeLabel.backgroundColor = UIColor.hx337ab7.withAlphaComponent(0.2)
        gprsSign.backgroundColor = UIColor.hx888b9a
        gprsSign.mask = UIImageView(image: gprsIcon)
        
        addSubview(imageV)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(tagsV)
        addSubview(priceLabel)
        addSubview(dateLabel)
        addSubview(rentModeLabel)
        addSubview(bottomV)
        bottomV.addSubview(gprsSign)
        bottomV.addSubview(trafficLabel)
        
        imageV.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(15)
            make.size.equalTo(CGSize.init(width: 108, height: 81))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageV)
            make.left.equalTo(imageV.snp.right).offset(10)
            make.right.equalTo(-15)
        }
        addressLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.right.equalTo(rentModeLabel.snp.left).offset(-10)
        }
        rentModeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(titleLabel)
            make.centerY.equalTo(addressLabel)
        }
        addressLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 100), for: .horizontal)
        rentModeLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 900), for: .horizontal)
        tagsV.snp.makeConstraints { (make) in
            make.left.equalTo(addressLabel)
            make.bottom.equalTo(priceLabel.snp.top)
            make.top.equalTo(addressLabel.snp.bottom)
            make.right.equalTo(titleLabel)
        }
        priceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.bottom.equalTo(imageV)
        }
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(priceLabel)
            make.right.equalTo(titleLabel)
        }
        bottomV.snp.makeConstraints { (make) in
            make.top.equalTo(imageV.snp.bottom)
            make.left.equalTo(imageV)
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(self)
            make.height.equalTo(30)
        }
        gprsSign.snp.makeConstraints { (make) in
            make.centerY.left.equalTo(bottomV)
            make.size.equalTo(gprsIcon!.size)
        }
        trafficLabel.snp.makeConstraints { (make) in
            make.left.equalTo(gprsSign.snp.right).offset(5)
            make.centerY.right.equalTo(bottomV)
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
    
    func addTagsLabel(house: House) {
        tagsV.subviews.forEach { (v) in
            v.removeFromSuperview()
        }
        //房间结构(几室几厅)
        if !house.style.isEmpty {
            let stylePrefix = house.style.components(separatedBy: "厅")[0] + "厅"
            if stylePrefix.count >= 4 {
                let styleLabel = TagLabel()
                styleLabel.text = stylePrefix
                tagsV.addSubview(styleLabel)
            }
        }
        //主卧或次卧
        if house.rent_mode == "合租" {
            let rentModeLabel = TagLabel()
            rentModeLabel.text = String(house.style[house.style.index(house.style.endIndex, offsetBy: -2)..<house.style.endIndex])
            tagsV.addSubview(rentModeLabel)
        }
        //独立卫生间
        if let facilities = house.facilities {
            if facilities.contains("独立卫生间") {
                let toiletLabel = TagLabel()
                toiletLabel.text = "独卫"
                tagsV.addSubview(toiletLabel)
            }
        }
        //转租优惠
        if !house.benefit.isEmpty {
            let benefitLabel = TagLabel()
            benefitLabel.text = "转租优惠"
            benefitLabel.backgroundColor = UIColor.colorWithHex(hex: 0x34c86c, alpha: 0.2)
            benefitLabel.textColor = UIColor.hx34c86c
            tagsV.addSubview(benefitLabel)
        }
        
        for (i, label) in tagsV.subviews.enumerated() {
            if i==0 {
                label.snp.makeConstraints({ (make) in
                    make.left.equalTo(tagsV)
                    make.centerY.equalTo(tagsV)
                })
            } else {
                label.snp.makeConstraints({ (make) in
                    make.left.equalTo(tagsV.subviews[i-1].snp.right).offset(8)
                    make.centerY.equalTo(tagsV)
                })
            }
        }
    }
}

class TagLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.colorWithRGBA(r: 89, g: 97, b: 103, a: 0.2)
        textColor = UIColor.colorWithRGB(r: 89, g: 97, b: 103)
        font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
