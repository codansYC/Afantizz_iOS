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
    lazy var districts: Variable<[District]> = {
        let unlimite = District()
        unlimite.district_name = "不限"
        let districts = [unlimite] + (ConfigManager.baseConfig?.cities?.first?.districts ?? [District]())
        return Variable(districts)
    }()
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: Global.ScreenWidth, height: 44*CGFloat((districts.value.count+4)/5)+20)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: Global.ScreenWidth/5, height: 44)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionV = BaseCollectionView(frame: rect, collectionViewLayout: layout)
        addSubview(collectionV)
        collectionV.backgroundColor = UIColor.white
        collectionV.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        collectionV.register(DistrictOptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        districts.asObservable().bind(to: collectionV.rx.items(cellIdentifier: reuseIdentifier, cellType: DistrictOptionCell.self)) { row, model, cell in
            cell.district = model
        }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
