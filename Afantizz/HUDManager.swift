//
//  HUDManager.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/4.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import MBProgressHUD

class HUDManager {
    
    @discardableResult
    static func show(message: String, in view: UIView, autoHideDelay: TimeInterval = 1) -> MBProgressHUD {
        let hud = CMBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.mode = .text
        hud.hide(animated: true, afterDelay: autoHideDelay)
        return hud
    }
    
    @discardableResult
    static func showNetworkError(in view: UIView) -> MBProgressHUD {
        return show(message: BizConsts.networkPoorMsg, in: view)
    }
    
    static func showLoading(message: String = "") -> CMBProgressHUD? {
        guard let view = UIViewController.getCurrentController()?.view else {
            return nil
        }
        let hud = CMBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = message
        hud.mode = .indeterminate
        return hud
    }

    
}

class CMBProgressHUD: MBProgressHUD {
    
    override init(view: UIView) {
        super.init(view: view)
        customizeInterface()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customizeInterface()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customizeInterface() {
    
        removeFromSuperViewOnHide = true
        label.numberOfLines = 0
        minShowTime = 0.5
        animationType = .zoomOut
        bezelView.style = .solidColor
        bezelView.color = UIColor.black.withAlphaComponent(0.8)
        contentColor = UIColor.white
    }

}