//
//  House.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import HandyJSON

class House: HandyJSON {
    
    var house_id = ""
    var title = ""
    var district = ""
    var address = ""
    var traffic = ""
    var price = ""
    var release_date = ""
    var rent_mode = ""
    var style = ""
    var benefit = ""
    var facilities: [String]?
    var images = [String]()
    
    required init() {}


}
