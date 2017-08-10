//
//  UserDefaults+extension.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/10.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

extension UserDefaults {
    
    static let tokenIdentifier = "token"
    
    class func saveToken(_ token: String?) {
        UserDefaults.standard.set(token, forKey: tokenIdentifier)
        UserDefaults.standard.synchronize()
        Global.token = token
    }
    
    class func getToken() -> String? {
        return UserDefaults.standard.value(forKey: tokenIdentifier) as? String
    }
    
    class func removeToken() {
        UserDefaults.standard.removeObject(forKey: tokenIdentifier)
    }
}
