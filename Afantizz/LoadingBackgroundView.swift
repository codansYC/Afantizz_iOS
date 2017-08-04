//
//  LoadingBackgroundView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import SnapKit

class LoadingBackgroundView: BaseView {

    var indicatorV: UIActivityIndicatorView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        indicatorV = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        addSubview(indicatorV)
        indicatorV.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let superV = superview else {
            indicatorV.stopAnimating()
            return
        }
        self.snp.makeConstraints { (make) in
            make.edges.equalTo(superV)
        }
        indicatorV.startAnimating()
    }
}
