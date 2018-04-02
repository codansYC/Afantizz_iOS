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
    
    static let sortTypeArr = ["最新","面积","价格","入住时间"]
    
    var filterDistrict: District?
    var filterPriceRange: PriceRange?
    var filterRentType: House.RentType?
    var filterSubway: String?
    var sortType: SortType?

    required init() {
        super.init(pullUrl: ServerUrl.houseList)
    }
    
    override func willSendRequest() {
        params.removeAll()
        if let districtCode = filterDistrict?.district_code {
            params["district_code"] = districtCode
        }
        if let minPrice = filterPriceRange?.min_price {
            params["min_price"] = minPrice
        }
        if let maxPrice = filterPriceRange?.max_price {
            params["max_price"] = maxPrice
        }
        if let rentType = filterRentType?.rawValue {
            params["rent_type"] = rentType
        }
        if let subway = filterSubway {
            params["subway"] = subway
        }
        if let sortType = sortType?.rawValue {
            params["sort_type"]  = sortType
        }
    }
    
    enum SortType: Int {
        case publishDate, area, price, areaDate
        
        var description: String {
            return HouseListViewModel.sortTypeArr[rawValue]
        }
    }
    
    var filterCategories: [String] {
        let districtTitle = filterDistrict?.district_name ?? "区域"
        var priceTitle = "租金"
        if let minPrice = filterPriceRange?.min_price,
            let maxPrice = filterPriceRange?.max_price {
            priceTitle = minPrice + "-" + maxPrice
        } else if let minPrice = filterPriceRange?.min_price {
            priceTitle = minPrice + "以上"
        } else if let maxPrice = filterPriceRange?.max_price {
            priceTitle = maxPrice + "以下"
        }
        let rentTypeTitle = filterRentType?.description ?? "户型"
        let subway = filterSubway ?? "地铁"
        return [districtTitle, priceTitle, rentTypeTitle, subway]
    }
}

