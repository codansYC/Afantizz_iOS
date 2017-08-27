//
//  Global.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/8.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class Global {

    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let ScreenWidth = UIScreen.main.bounds.width
    static let ScreenHeight = UIScreen.main.bounds.height
    static var memoryToken: String?
    static var user: User?
    
    static var isLogin: Bool {
        return token != nil
    }
    
    static var token: String? {
        if let token = memoryToken {
            return token
        }
        if let token = user?.token {
            memoryToken = token
            return token
        }
        
        if let token = UserDefaults.getToken() {
            memoryToken = token
            return token
        }
        return nil
    }
    
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
    
    class func toLoginPage() {
        let naviVC = NavigationController(rootViewController: LoginController())
        UIViewController.getCurrentController()?.present(naviVC, animated: true, completion: nil)
    }
    
    class func clearUserInfo() {
        Global.user = nil
        Global.memoryToken = nil
        UserDefaults.removeToken()
    }

}



