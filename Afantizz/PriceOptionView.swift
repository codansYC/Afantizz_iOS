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
    var items = Variable(["不限", "1000", "1000~1500", "1500~2000", "2000~2500", "2500~3000", "3000~4000", "4000~5000", "5000以上"])
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: min(350, 44*CGFloat(items.value.count)+20))
        tableView = BaseTableView(frame: rect, style: .plain)
        addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        tableView.register(PriceAndSubwayOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        items.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PriceAndSubwayOptionCell.self)) { row, model, cell in
            cell.item = model
        }.addDisposableTo(disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
