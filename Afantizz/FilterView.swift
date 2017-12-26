//
//  FilterCollectionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FilterView: BaseView {

    var collectionV: BaseCollectionView!
    let items = Variable(["区域","租金","户型","地铁"])
    
    let reuseIdentifier = "cell"
    
    init() {
        let rect = CGRect(x: 0, y: 0, width: Global.ScreenWidth, height: 45)
        super.init(frame: rect)
        setUpCollectionView()
        let line = UIView(frame: CGRect(x: 0, y: 44, width: Global.ScreenWidth, height: 1))
        line.backgroundColor = UIColor.hxedeff3
        addSubview(line)
        backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCollectionView() {
        let rect = CGRect(x: 0, y: 0, width: Global.ScreenWidth, height: 44)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (Global.ScreenWidth-3)/4, height: 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 1
        collectionV = BaseCollectionView(frame: rect, collectionViewLayout: layout)
        addSubview(collectionV)
        collectionV.backgroundColor = UIColor.hxedeff3
        collectionV.register(FilterCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        items.asObservable().bind(to: collectionV.rx.items(cellIdentifier: reuseIdentifier, cellType: FilterCell.self)) { row, model, cell in
            cell.item = model
        }.disposed(by: disposeBag)
    }

}
