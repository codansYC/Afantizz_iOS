//
//  SortSlideView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/28.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift

class SortSlideView: SlideView {

    let tableView = UITableView(frame: CGRect.zero, style: .plain)
    let items = Variable(["最新","面积","价格","入住时间"])
    
    override init() {
        super.init()
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        tableView.tableHeaderView = SectionView(height: 10)
        tableView.tableHeaderView?.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        tableView.rowHeight = 40
        tableView.register(SortCell.self, forCellReuseIdentifier: "cell")
        items.asObservable().bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: SortCell.self)) { row, model, cell in
            cell.item = model
            }.disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            self.tableView.selectRow(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .none)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class SortCell: BaseTableViewCell {
    
    var item: String = "" {
        didSet{
            itemLabel.text = item
        }
    }
    
    let itemLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        itemLabel.font = UIFont.systemFont(ofSize: 15)
        itemLabel.textColor = UIColor.hx596167
        addSubview(itemLabel)
        itemLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        itemLabel.textColor = selected ? UIColor.hx34c86c : UIColor.hx596167
    }
}
