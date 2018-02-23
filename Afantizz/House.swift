//
//  House.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class House: BaseModel {
    
    var house_id: String?
    var title: String?
    var price: String?
    var district: String?
    var address: String?
    var rent_type: Int?
    var traffic: String?
    var date: String?
    var is_benefit: Bool?
    var room_num: Int?
    var hall_num: Int?
    var kitchen_type: Int?
    var is_toilet_single: Bool?
    var room_type: Int?
    var image: String?
    
    var rentType: RentType? {
        guard let type = rent_type else {
            return nil
        }
        return RentType(rawValue: type)
    }
    
    var roomType: RoomType? {
        guard let type = room_type else {
            return nil
        }
        return RoomType(rawValue: type)
    }
    
    required init() {}
    
    enum RentType: Int, BaseModel {
        init() {
            self.init()
        }
        
        case joint = 1
        case entire
        case apartment
        
        var description: String {
            switch self {
            case .joint:
                return "合租"
            case .entire:
                return "整租"
            case .apartment:
                return "公寓"
            }
        }
    }
    
    enum RoomType: Int, BaseModel {
        init() {
            self.init()
        }
        
        case master = 1
        case second
        case compartment
        case bed
        
        var description: String {
            switch self {
            case .master:
                return "主卧"
            case .second:
                return "次卧"
            case .compartment:
                return "隔段"
            case .bed:
                return "床位"
            }
        }
    }

}


