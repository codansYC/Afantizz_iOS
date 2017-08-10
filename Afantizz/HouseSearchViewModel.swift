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
    
    func validKeyword(_ keyword: String?) -> (Bool, String) {
        if keyword == nil || keyword == "" {
            return (false, "关键字不能为空")
        }
        if keyword!.isEmpty {
             return (false, "关键字不能全为空格")
        }
        return (true, "")
    }
    
    func search(_ keyword: String) {
        let currentVC = UIViewController.getCurrentController()
        let params: [String: Any] = ["search_keyword": keyword]
        Networker.request(url: ServerUrl.houseSearch, params: params, success: { (jsonStr) in
            self.searchResult.value = [House].deserialize(from: jsonStr) ?? [House]()
        }, error: { (errCode, errMsg) in
            if let vc = currentVC {
                HUDManager.show(message: errMsg, in: vc.view)
            }
        }, networkError: {
            if let vc = currentVC {
                HUDManager.show(message: BizConsts.networkPoorMsg, in: vc.view)
            }
        })
    }

}
