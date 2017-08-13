//
//  BaseView.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/11.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class BaseView: UIView {

    lazy var disposeBag: DisposeBag = DisposeBag()

}

class SectionView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hxedeff3
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        backgroundColor = UIColor.hxedeff3
    }
}

