//
//  HouseListViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/15.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class HouseListViewModel: PagingViewModel<House> {
    
    var district = Str.unlimited
    var price = Str.unlimited
    var rentMode = Str.unlimited
    var style = Str.unlimited
    var subway = Str.unlimited
    var sort = ""

    init() {
        super.init(pullUrl: ServerUrl.houseList)
    }
    
    override func willSendRequest() {
        params["district"]  = district == Str.unlimited ? "" : district
        params["price"]     = price    == Str.unlimited ? "" : price
        params["rent_mode"] = rentMode == Str.unlimited ? "" : rentMode
        params["style"]     = style    == Str.unlimited ? "" : style
        params["subway"]    = subway   == Str.unlimited ? "" : subway
        params["sort"]      = sort
    }
}
