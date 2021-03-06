//
//  TabBarController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.hx888b9a], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.hx337ab7], for: .selected)
        tabBar.tintColor = UIColor.hx337ab7
        tabBar.isTranslucent = false
        self.delegate = self
        addChildren()
    }
    
    
    func addChildren() -> Void {
        let houseListVC = HouseListController()
        let releaseVC = ReleaseController()
        releaseVC.title = "发布房源"
        let mineVC = MineController()
        addChild(houseListVC, title: "房源", image: UIImage(named: "home"))
        addChild(releaseVC, title: "发布", image: UIImage(named: "edit"))
        addChild(mineVC, title: "我的", image: UIImage(named: "mine"))
    }
    
    func addChild(_ viewController: UIViewController, title: String, image: UIImage?) -> Void {
        
        let tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        
        let nav = NavigationController(rootViewController: viewController)
        nav.tabBarItem = tabBarItem
        addChildViewController(nav)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard (viewController as? UINavigationController)?.topViewController is ReleaseController else {
            return true
        }
        
        if !Global.isLogin {
            Global.toLoginPage()
            return false
        }
        
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        switch index {
        case 1:
            guard let releaseVC = (viewController as? UINavigationController)?.topViewController as? ReleaseController else {
                return
            }
            let urlStr = ServerUrl.releaseH5.toMobileWeb() + "?token=" + (Global.token ?? "")
            releaseVC.urlStr = urlStr
        default:
            break
        }
    }
    
}
