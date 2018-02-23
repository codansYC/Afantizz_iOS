//
//  HouseSearchViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/8.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HouseSearchViewModel: BaseViewModel {
    
    var searchResult = Variable([House?]())
    
    func validKeyword(_ keyword: String?) -> (isValid: Bool, msg: String) {
        if keyword == nil || keyword == "" {
            return (false, "关键字不能为空")
        }
        if keyword!.isEmpty {
             return (false, "关键字不能全为空格")
        }
        return (true, "")
    }
    
    func search(_ keyword: String) {
        let params: [String: Any] = ["keyword": keyword]
        [House].request(url: ServerUrl.houseSearch, params: params, success: { houseList in
            self.requestError.value = nil
            self.searchResult.value = houseList ?? []
        }, error: { (err) in
            self.requestError.value = err
        })
    }

}
