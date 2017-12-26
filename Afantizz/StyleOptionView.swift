//
//  StyleOptionView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/14.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StyleOptionView: HouseOptionView {
    
    var firstTableView: BaseTableView!
    var secondTableView: BaseTableView!
    var line: BaseView!
    let reuseIdentifier1 = "cell1"
    let reuseIdentifier2 = "cell2"
    var containerV: BaseView!
    let items1 = Variable(["不限", "整租", "合租", "公寓"])
    let items2 = Variable(["不限", "一居", "二居", "三居", "四居及以上"])
    
    override init() {
        super.init()
        
        containerV = BaseView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: CGFloat(items1.value.count)*44+20))
        containerV.backgroundColor = UIColor.white
        addSubview(containerV)
        line = BaseView()
        line.backgroundColor = UIColor.hxedeff3
        containerV.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.top.bottom.centerX.equalTo(containerV)
            make.width.equalTo(1)
        }

        firstTableView = BaseTableView()
        secondTableView = BaseTableView()
        firstTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        secondTableView.contentInset = UIEdgeInsetsMake(10, 0, 10, 0)
        firstTableView.register(FirstStyleCell.self, forCellReuseIdentifier: reuseIdentifier1)
        secondTableView.register(SecondStyleCell.self, forCellReuseIdentifier: reuseIdentifier2)
        
        containerV.addSubview(firstTableView)
        containerV.addSubview(secondTableView)
        firstTableView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalTo(containerV)
            make.right.equalTo(containerV.snp.centerX).offset(-0.5)
        }
        secondTableView.snp.makeConstraints { (make) in
            make.left.equalTo(containerV.snp.centerX).offset(0.5)
            make.top.right.bottom.equalTo(containerV)
        }
        
        items1.asObservable().bind(to: firstTableView.rx.items(cellIdentifier: reuseIdentifier1, cellType: FirstStyleCell.self)) { row, model, cell in
            cell.item = model
            cell.arrow.isHidden = row == 0 || row == 3
            }.disposed(by: disposeBag)
        
        items2.asObservable().bind(to: secondTableView.rx.items(cellIdentifier: reuseIdentifier2, cellType: SecondStyleCell.self)) { row, model, cell in
            cell.item = model
        }.disposed(by: disposeBag)
        
        firstTableView.rx.itemSelected.bind { [unowned self] indexPath in
            self.showSecondTableView(show: indexPath.row == 1 || indexPath.row == 2)
            }.disposed(by: disposeBag)
        
        showSecondTableView(show: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSecondTableView(show: Bool) {
        if show {
            self.line.isHidden = false
            self.secondTableView.isHidden = false
            self.containerV.frame.size.height = CGFloat(self.items2.value.count*44+20)
        } else {
            self.line.isHidden = true
            self.secondTableView.isHidden = true
            self.containerV.frame.size.height = CGFloat(self.items1.value.count*44+20)
        }
        
        secondTableView.selectRow(at: nil, animated: true, scrollPosition: .none)
    }
}
