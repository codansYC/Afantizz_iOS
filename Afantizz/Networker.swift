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
import CryptoSwift

typealias JsonString = String

typealias SuccessClosure = (JsonString?) -> Void
typealias ErrorClosure = (AfantizzError) -> Void
typealias NetworkErrorClosure = ()->Void

struct Networker {
    
    //MARK: - 网络请求
    static func request(url: String, params: [String: Any]? = nil, success: SuccessClosure? = nil, error: ErrorClosure? = nil, networkError: NetworkErrorClosure? = nil) {
        let _url = fixUrlStr(url)
        let isRequestTimestamp = url == ServerUrl.timestamp
        let _params = addBaseParams(params: params, isRequestTimestamp: isRequestTimestamp)
        Alamofire.request(_url, method: .post, parameters: _params).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let result = JSON(value)
                guard let errCode = result["err_code"].int,
                      let errMsg = result["err_msg"].string else {
                        debugAlert(items: "服务器数据格式错误")
                        return
                }
                if errCode != 0 {
                    //请求失败
                    error?(AfantizzError(code: errCode, msg: errMsg))
                    handleError(errCode: errCode)
                    return
                }
                success?(result["data"].rawString())
            case .failure(let error):
                let ns_err = error as NSError
                if ns_err.code == BizConsts.networkPoorCode {
                    networkError?()
                    return
                }
                debugPrint("url=\(_url)--params=\(_params)")
                handleFailure(error: ns_err)
            }
        }
    }
    
    //MARK: - 必传参数
    
    //MARK: - 处理url
    static func fixUrlStr(_ url: String) -> String {
        var requsetUrl = url
        if !url.hasPrefix("http://") && !url.hasPrefix("https://") {
            requsetUrl = ServerUrl.basicUrl + url
        }
        return requsetUrl
    }
    
    /**     
     添加基础参数
     */
    static func addBaseParams(params: [String: Any]?, isRequestTimestamp: Bool) -> [String: Any] {
        var para = params ?? [String: Any]()
        para["app_version"] = App.version
        para["platform"] = App.platform
        para["timestamp"] = isRequestTimestamp ? Int(Date().timeIntervalSince1970) : Global.timestamp.serverCurrentTimestamp
        para["request_id"] = Global.random(100000000, 999999999)
        let arr = [App.key, "\(para["timestamp"]!)", "\(para["request_id"]!)"].sorted()
        para["signature"] = arr.joined().sha1()
        return para
    }
    
    //MARK: - 错误返回（针对服务器返回的错误）
    static func handleError(errCode: Int) {
        switch errCode {
        case ErrorCode.timeout:
            Global.syncTimestamp()
        default:
            break
        }
    }
    
    //MARK: - 请求失败（针对于网络异常,传参错误,服务器错误等情况）
    static func handleFailure(error: NSError) {
        switch error.code {
        case BizConsts.networkPoorCode:
            debugPrint("网络异常")
        default:
            debugPrint("错误请求:\(error.localizedDescription)")
            debugAlert(items: error.localizedDescription)
        }
    }
    
}

extension Networker {
    struct ErrorCode {
        static let timeout = 10006
    }
}



