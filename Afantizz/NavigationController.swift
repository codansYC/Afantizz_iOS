//
//  NavigationController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.barTintColor = UIColor.navBarColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.tintColor = UIColor.white
        navigationBar.backIndicatorImage = UIImage(named: "back")
        navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "back")
    }
    
}


extension UINavigationController {
    func setBarBackgroundColor(_ color: UIColor) {
        navigationBar.setBackgroundImage(UIImage.imageWithColor(color), for: .default)
    }
}
