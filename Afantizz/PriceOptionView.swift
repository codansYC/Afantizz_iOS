//
//  PriceOptionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PriceOptionView: HouseOptionView {
    
    let reuseIdentifier = "cell"
    var tableView: BaseTableView!
    lazy var priceRanges: Variable<[PriceRange]> = {
        let priceRangeArr = [PriceRange()] + (ConfigManager.baseConfig?.price_range_arr ?? [PriceRange]())
        return Variable(priceRangeArr)
    }()
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: min(350, 44*CGFloat(priceRanges.value.count)+20))
        tableView = BaseTableView(frame: rect, style: .plain)
        addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        tableView.register(PriceAndSubwayOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        priceRanges.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PriceAndSubwayOptionCell.self)) { row, model, cell in
            cell.priceRange = model
            }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
