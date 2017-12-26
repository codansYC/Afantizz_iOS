//
//  MineController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/12.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MineController: TableController, UITableViewDelegate, UITableViewDataSource {
    
    let reuseIdentifier = "cell"
    let sectionH: CGFloat = 10
    let topView = MineTopView()
    let bottomView = MineBottomView()
    let mineVM = MineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpEvents()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mineVM.getUserInfoIfLogin()
    }
    
    func setUpViews() {
        title = "我的"
        view.backgroundColor = UIColor.hxedeff3
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        tableView.backgroundColor = UIColor.hxedeff3
        tableView.tableHeaderView = topView
        tableView.tableFooterView = bottomView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = sectionH
        tableView.showsVerticalScrollIndicator = false
    }
    
    func setUpEvents() {
        mineVM.loginState.asObservable().bind { [unowned self] (isLogin) in
            self.topView.loginState.value = isLogin
            self.bottomView.loginState.value = isLogin
        }.disposed(by: disposeBag)
        
        bottomView.actionBtn.rx.tap.bind { [unowned self] in
            if Global.isLogin {
                self.mineVM.alertTologOff()
            } else {
                Global.toLoginPage()
            }
        }.disposed(by: disposeBag)
    }
    
    //MARK: -  tableView delegate datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return SectionView(height: sectionH)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textColor = UIColor.hx333
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            if row == 0 {
                cell.textLabel?.text = "我的发布"
                let line = SectionView(height: 1)
                cell.addSubview(line)
                line.snp.makeConstraints { (make) in
                    make.bottom.right.equalTo(cell)
                    make.left.equalTo(15)
                    make.height.equalTo(1)
                }

            } else {
                cell.textLabel?.text = "我的收藏"
            }
        case 1:
            cell.textLabel?.text = "意见反馈"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            if row == 0 {
                mineVM.toMyReleasePageIfLogin()
            } else {
                mineVM.toMyCollectionPageIfLogin()
            }
        case 1:
            mineVM.toFeedbackPage()
        default:
            break
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        topView.adjustBgImgV(offset_y: scrollView.contentOffset.y)
    }

}
