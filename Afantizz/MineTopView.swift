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
    var infoBg: UIView!
    var headImgV: UIImageView!
    var textLabel: UILabel!
    let bgImgVH: CGFloat = 240
    let infoBgH: CGFloat = 86
    
    var loginState = Variable(false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        bgImgV = UIImageView(image: UIImage(named: "mineBg.jpg"))
        bgImgV.contentMode = .center
        addSubview(bgImgV)
        
        infoBg = UIView()
        addSubview(infoBg)
        infoBg.backgroundColor = UIColor.white
        
        let headIcon = UIImage(named: "head-icon.png")
        headImgV = UIImageView(image: headIcon)
        infoBg.addSubview(headImgV)
        
        textLabel = UILabel()
        textLabel.text = "未登录"
        textLabel.textColor = UIColor.hx596167
        textLabel.font = UIFont.systemFont(ofSize: 15)
        infoBg.addSubview(textLabel)
        
        bgImgV.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(bgImgVH)
            make.bottom.equalTo(infoBg.snp.top)
        }
        
        infoBg.snp.makeConstraints { (make) in
            make.bottom.right.left.equalTo(self)
            make.height.equalTo(infoBgH)
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

        self.frame.size.height = bgImgVH + infoBgH
        
        loginState.asObservable().bind { [unowned self] (isLogin) in
            self.textLabel.text = isLogin ? Global.user?.phone : "未登录"
        }.addDisposableTo(disposeBag)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func adjustBgImgV(offset_y: CGFloat) {
        if offset_y > 0 { return }
        let img = bgImgV.image!
        let img_p: CGFloat = img.size.width / img.size.height
        let height = bgImgVH - offset_y
        var width = self.frame.size.width
        if height > img.size.height {
            bgImgV.contentMode = .scaleAspectFit
            width = height * img_p
        } else {
            bgImgV.contentMode = .center
        }
        bgImgV.snp.remakeConstraints { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(width)
            make.height.equalTo(height)
            make.bottom.equalTo(infoBg.snp.top)
        }
        bgImgV.backgroundColor = UIColor.red
        
    }

}
