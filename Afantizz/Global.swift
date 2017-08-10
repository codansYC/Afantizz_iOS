//
//  Global.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/8.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class Global {

    static let ScreenWidth = UIScreen.main.bounds.width
    static var token: String?
    static var user: User?
    
    class func validateMobile(_ mobile: String?) -> Bool {
        guard let mobile = mobile else {
            return false
        }
        let phoneRegex = "^(((1[3|4|5|7|8|9]{1}[0-9]{1}))[0-9]{8})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        let result = phoneTest.evaluate(with: mobile)
        return result
    }
    
    class func validateCaptcha(_ number: String?) -> Bool {
        guard let number = number else {
            return false
        }
        let regex = "^[0-9]{6}"
        let test = NSPredicate(format: "SELF MATCHES %@", regex)
        let result = test.evaluate(with: number)
        return result
    }

}


