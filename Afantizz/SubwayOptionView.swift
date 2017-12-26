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
    var items = Variable(["不限", "1号线", "2号线", "3号线", "4号线", "5号线", "6号线", "7号线", "8号线", "9号线", "10号线", "11号线", "12号线", "13号线", "14号线", "15号线", "16号线", "17号线", "18号线"])
    
    override init() {
        super.init()
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: min(350, 44*CGFloat(items.value.count)+20))
        tableView = BaseTableView(frame: rect, style: .plain)
        addSubview(tableView)
        tableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        tableView.register(PriceAndSubwayOptionCell.self, forCellReuseIdentifier: reuseIdentifier)
        items.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: PriceAndSubwayOptionCell.self)) { row, model, cell in
            cell.item = model
            }.disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
