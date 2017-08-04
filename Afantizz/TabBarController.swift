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

        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.hx888b9a], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.hx337ab7], for: .selected)
        tabBar.tintColor = UIColor.hx337ab7
        addChildren()
    }
    
    
    dynamic func addChildren() -> Void {
        
        addChild(HouseListController(), title: "房源", image: UIImage(named: "home"))
        let releaseWebVC = WebViewController(URLStr: "http://afantizz.com/m/release.html")
        addChild(releaseWebVC, title: "发布", image: UIImage(named: "edit"))
        let mineWebVC = WebViewController(URLStr: "http://afantizz.com/m/mine.html")
        addChild(mineWebVC, title: "我的", image: UIImage(named: "mine"))
        
    }
    
    func addChild(_ viewController: UIViewController, title: String, image: UIImage?) -> Void {
        
        let tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate))
        
        let nav = NavigationController(rootViewController: viewController)
        nav.tabBarItem = tabBarItem
        addChildViewController(nav)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let index = tabBarController.selectedIndex
        if index != 0 {
            let naviVC = tabBarController.viewControllers?[index] as? UINavigationController
            naviVC?.setNavigationBarHidden(true, animated: false)
        }
    }
    
}
