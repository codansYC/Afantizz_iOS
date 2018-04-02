//
//  AppDelegate.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/10.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

let isDev = false
let isDebug = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var tabBarVC: TabBarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        Global.syncTimestamp {
            ConfigManager.obtainBaseConfig {
                self.tabBarVC = TabBarController()
                self.window?.rootViewController = self.tabBarVC
            }
        }
        SDKManager.configure(options: launchOptions)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LaunchController()
        window?.makeKeyAndVisible()
        application.setStatusBarStyle(.lightContent, animated: false)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        ShareManager.default.handleOpenURL(url)
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        ShareManager.default.handleOpenURL(url)
        return true
    }
}




