//
//  MineBottomView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/13.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class MineBottomView: BaseView {
    
    let actionBtn = UIButton()
    let loginState = Variable(false)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame.size.height = 150
        actionBtn.layer.cornerRadius = 4
        actionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        addSubview(actionBtn)
        actionBtn.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(15)
            make.right.equalTo(-15)
        }

        loginState.asObservable().bind { [unowned self] (isLogin) in
            let title = isLogin ? "退出登录" : "登录"
            let bgColor = isLogin ? UIColor.dangerBgColor : UIColor.safeBgColor
            let bdColor = isLogin ? UIColor.dangerBorderColor : UIColor.safeBorderColor
            self.actionBtn.setTitle(title, for: .normal)
            self.actionBtn.backgroundColor = bgColor
            self.actionBtn.layer.borderColor = bdColor.cgColor
        }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
