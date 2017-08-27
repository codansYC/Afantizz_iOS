//
//  HouseOptionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit

class HouseOptionView: BaseView {

    var obscureView: BaseView!
    
    init() {
        let rect = CGRect(x: 0, y: 45, width: Global.ScreenWidth, height: Global.ScreenHeight-64-49-45)
        super.init(frame: rect)
        obscureView = BaseView()
        addSubview(obscureView)
        obscureView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        obscureView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        let tap = UITapGestureRecognizer()
        tap.rx.event.bind { [unowned self] (tap) in
            self.removeFromSuperview()
            NotificationCenter.default.post(name: Notification.Name.FilterViewDidRemoved, object: self)
        }.addDisposableTo(disposeBag)
        obscureView.addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        NotificationCenter.default.post(name: NSNotification.Name.FilterViewDidRemoved, object: self)
    }
    
}
