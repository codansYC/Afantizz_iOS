//
//  Networker.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias JsonString = String

typealias SuccessClosure = (JsonString?) -> Void
typealias ErrorClosure = (Int, String) -> Void
typealias NetworkErrorClosure = (Void)->Void

class Networker: NSObject {
    
    //MARK: - 网络请求
    static func request(url: String, params: [String: Any]? = nil, success: SuccessClosure? = nil, error: ErrorClosure? = nil, networkError: NetworkErrorClosure?) {
        
        Alamofire.request(fixUrlStr(url), method: .post, parameters: params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                guard let errCode = json["err_code"].int,
                      let errMsg = json["err_msg"].string else {
                        print("服务器数据格式错误")
                        return
                }
                
                if errCode != 0 {
                    //请求失败
                    error?(errCode, errMsg)
                    return
                }
                
                success?(json["data"].rawString())
                
            case .failure(let error):
                let ns_err = error as NSError
                if ns_err.code == BizConsts.networkPoorCode {
                    networkError?()
                }
                handleFailure(error: ns_err)
            }
        }
    }
    
    //MARK: - 必传参数
    
    //MARK: - 处理url
    static func fixUrlStr(_ url: String) -> String {
        var requsetUrl = url
        if !url.hasPrefix("http://") || !url.hasPrefix("https://") {
            requsetUrl = ServerUrl.basicUrl + url
        }
        return requsetUrl
    }
    
    //MARK: - 请求失败（针对于网络异常以及传参错误）
    static func handleFailure(error: NSError) {
        switch error.code {
        case BizConsts.networkPoorCode:
            print("网络异常")
        default:
            print("请检查url或者参数是否正确")
        }
    }
}
