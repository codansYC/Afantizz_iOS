//
//  DistrictOptionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DistrictOptionView: HouseOptionView {
    
    let reuseIdentifier = "cell"
    var collectionV: BaseCollectionView!
    var items = Variable(["不限", "浦东", "闵行", "宝山", "徐汇", "普陀", "杨浦", "长宁", "松江", "嘉定", "黄埔", "静安", "闸北", "虹口", "青浦", "奉贤", "金山", "崇明", "上海周边"])
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: Global.ScreenWidth, height: 44*CGFloat((items.value.count+4)/5)+20)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Global.ScreenWidth/5, height: 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionV = BaseCollectionView(frame: rect, collectionViewLayout: layout)
        addSubview(collectionV)
        collectionV.backgroundColor = UIColor.white
        collectionV.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        collectionV.register(DistrictOptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        items.asObservable().bind(to: collectionV.rx.items(cellIdentifier: reuseIdentifier, cellType: DistrictOptionCell.self)) { row, model, cell in
            cell.item = model
        }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
