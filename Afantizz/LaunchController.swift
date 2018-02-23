//
//  LaunchController.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/18.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class LaunchController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageV = UIImageView.init(image: UIImage.init(named: "afanti-launch"))
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
}
