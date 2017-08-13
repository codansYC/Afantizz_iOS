//
//  MineTopView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/12.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class MineTopView: BaseView {

    var bgImgV: UIImageView!
    var headImgV: UIImageView!
    var textLabel: UILabel!
    
    var loginState = Variable(false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        bgImgV = UIImageView(image: UIImage(named: "mineBg.jpg"))
        bgImgV.contentMode = .center
        addSubview(bgImgV)
        
        let infoBg = UIView()
        addSubview(infoBg)
        infoBg.backgroundColor = UIColor.white
        
        let headIcon = UIImage(named: "head-icon.png")
        headImgV = UIImageView(image: headIcon)
        infoBg.addSubview(headImgV)
        
        textLabel = UILabel()
        textLabel.text = "未登录"
        infoBg.addSubview(textLabel)
        
        bgImgV.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(240)
        }
        
        infoBg.snp.makeConstraints { (make) in
            make.bottom.right.left.equalTo(self)
            make.top.equalTo(bgImgV.snp.bottom)
        }
        
        headImgV.snp.makeConstraints { (make) in
            make.centerX.equalTo(infoBg)
            make.centerY.equalTo(infoBg.snp.top)
            make.size.equalTo(headIcon!.size)
        }
        textLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(headImgV)
            make.top.equalTo(headImgV.snp.bottom).offset(15)
        }

        self.frame.size.height = 240 + ceil(headIcon!.size.height/2) + 30 + textLabel.font.lineHeight

        loginState.asObservable().bind { [unowned self] (isLogin) in
            self.textLabel.text = isLogin ? Global.user?.phone : "未登录"
        }.addDisposableTo(disposeBag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
