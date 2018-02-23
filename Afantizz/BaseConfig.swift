//
//  BaseConfig.swift
//  Afantizz
//
//  Created by yuanchao on 2018/2/11.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class BaseConfig: Codable,BaseModel {
    
    var cities: [City]?
    var price_range_arr: [PriceRange]?
    var subways: [String]?
    
    required init() {}
}

class City: Codable,BaseModel {
    
    var city_code: String?
    var city_name: String?
    var districts: [District]?
    
    required init() {}
}

class District: Codable,BaseModel {
    var district_code: String?
    var district_name: String?
    
    required init() {}
}

class PriceRange: Codable, BaseModel {
    var max_price: String?
    var min_price: String?
    required init() {}
}
