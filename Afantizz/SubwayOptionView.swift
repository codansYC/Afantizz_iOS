//
//  SubwayOptionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubwayOptionView: HouseOptionView {
    
    let reuseIdentifier = "cell"
    var tableView: BaseTableView!
    lazy var subways: Variable<[String]> = {
        let subways = [Str.unlimited] + (ConfigManager.baseConfig?.subways ?? [])
        return Variable(subways)
    }()
    
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: min(350, 44*CGFloat(subways.value.count)+20))
        tableView = BaseTableView(frame: rect, style: .plain)
        addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        tableView.register(PriceAndSubwayOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        subways.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PriceAndSubwayOptionCell.self)) { row, model, cell in
            cell.item = model
            }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
