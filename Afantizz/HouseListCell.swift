//
//  HouseListCell.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import Kingfisher

class HouseListCell: UITableViewCell {
    
    let imageV = UIImageView()
    let titleLabel = UILabel()
    let addressLabel = UILabel()
    let priceLabel = UILabel()
    let dateLabel = UILabel()
    let trafficLabel = UILabel()
    let rentModeLabel = PaddingLabel.init(UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2))
    let gprsIcon = UIImage(named: "icon-gprs")
    let gprsSign = UIView()
    let tagsV = UIView()
    let bottomV = UIView()
    
    var house: House? {
        didSet{
            guard let house = house else {
                return
            }
            imageV.af.setImage(with: URL(string: house.image.wrapSafely))
            titleLabel.text = house.title
            addressLabel.text = house.district.wrapSafely + "-" + house.address.wrapSafely
            priceLabel.text = "¥" + house.price.wrapSafely
            dateLabel.text = house.date
            trafficLabel.text = house.traffic
            rentModeLabel.text = house.rentType?.description
            bottomV.snp.updateConstraints { (make) in
                make.height.equalTo(house.traffic?.isEmpty == true ? 10 : 30)
            }
            bottomV.isHidden = house.traffic?.isEmpty == true
            
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
        tagsV.subviews.forEach { $0.removeFromSuperview() }
        //房间结构(几室几厅)
        if let roomNum = house.room_num, let hallNum = house.hall_num {
            let styleLabel = TagLabel()
            styleLabel.text = "\(roomNum)室\(hallNum)厅"
            tagsV.addSubview(styleLabel)
        }
        //主卧或次卧
        if house.rentType == House.RentType.joint {
            let rentModeLabel = TagLabel()
            rentModeLabel.text = house.rentType?.description
            tagsV.addSubview(rentModeLabel)
        }
        //是否有独立卫生间
        if house.is_toilet_single == true {
            let toiletLabel = TagLabel()
            toiletLabel.text = "独卫"
            tagsV.addSubview(toiletLabel)
        }
        //转租优惠
        if house.is_benefit == true {
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
                    make.left.equalTo(tagsV.subviews[i-1].snp.right).offset(5)
                    make.centerY.equalTo(tagsV)
                })
            }
        }
    }
}

class TagLabel: PaddingLabel {
    
    init() {
        super.init(UIEdgeInsets.init(top: 0, left: 2, bottom: 0, right: 2))
        backgroundColor = UIColor.colorWithRGBA(r: 89, g: 97, b: 103, a: 0.2)
        textColor = UIColor.colorWithRGB(r: 89, g: 97, b: 103)
        font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
