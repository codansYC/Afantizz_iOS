//
//  UIViewController+extension.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    //MARK: - 获取第一个window顶部的控制器
    class dynamic func getCurrentController() -> UIViewController? {
        
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        return getCurrentControllerInWindow(window: window)
    }
    
    //MARK: - 获取最后一个window顶部的控制器
    class dynamic func getNearestController() -> UIViewController? {
        
        for window in UIApplication.shared.windows.reversed() {
            if let vc = getCurrentControllerInWindow(window: window) {
                return vc
            }
        }
        return nil
    }
    
    //MARK: - 获取指定window上顶部的控制器
    class dynamic func getCurrentControllerInWindow(window: UIWindow) -> UIViewController? {
        
        var tempView: UIView?
        
        for subview in window.subviews.reversed() {
            
            
            if subview.classForCoder.description() == "UILayoutContainerView" {
                
                tempView = subview
                
                break
            }
        }
        
        if tempView == nil {
            
            tempView = window.subviews.last
        }
        
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController || nextResponder?.classForCoder == NSClassFromString("UIInputWindowController")
        }
        
        while next{
            
            tempView = tempView?.subviews.first
            
            if tempView == nil {
                
                return nil
            }
            
            nextResponder = tempView!.next
        }
        
        return nextResponder as? UIViewController
        
    }

}
