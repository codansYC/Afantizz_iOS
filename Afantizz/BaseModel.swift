//
//  BaseModel.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/24.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import HandyJSON

protocol BaseModel: HandyJSON {}

extension BaseModel {
    //MARK: - 网络请求
    static func request(url: String, params: [String: Any]? = nil, designatedPath: String? = nil, success: ((Self?)->Void)? = nil, error: ErrorClosure? = nil, networkError: NetworkErrorClosure? = nil) {
        Networker.request(url: url, params: params, success: { (jsonStr) in
            let req = self.parase(from: jsonStr, designatedPath: designatedPath)
            success?(req)
        }, error: error, networkError: networkError)
    }
}

extension Array where Element: BaseModel {
    //MARK: - 网络请求
    static func request(url: String, params: [String: Any]? = nil, designatedPath: String? = nil, success: (([Element?]?)->Void)? = nil, error: ErrorClosure? = nil, networkError: NetworkErrorClosure? = nil) {
        Networker.request(url: url, params: params, success: { (jsonStr) in
            let req = self.parase(from: jsonStr, designatedPath: designatedPath)
            success?(req)
        }, error: error, networkError: networkError)
    }
}

extension BaseModel {
    static func parase(from json: String?, designatedPath: String? = nil) -> Self? {
        return self.deserialize(from: json, designatedPath: designatedPath)
    }
}

extension Array where Element: BaseModel {
    static func parase(from json: String?, designatedPath: String? = nil) -> [Element?]? {
        return self.deserialize(from: json, designatedPath: designatedPath)
    }
}

/* 原生解析
extension Decodable {

    static func decode(from json: String?, designatedPath: String? = nil) -> Self? {
        guard let jsonData = json?.data(using: .utf8) else {
            return nil
        }
        if let m = try? JSONDecoder().decode(Self.self, from: jsonData) {
            return m
        }
        return nil
    }
}

extension Array where Element: Decodable {
    static func decode(from json: String?, designatedPath: String? = nil) -> [Element]? {
        guard let jsonData = json?.data(using: .utf8) else {
            return nil
        }
        if let mArr = try? JSONDecoder().decode([Element].self, from: jsonData) {
            return mArr
        }
        return nil
    }
}
 */


