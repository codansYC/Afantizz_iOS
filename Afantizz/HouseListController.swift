//
//  HouseListController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/3.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HouseListController: PagingController<House, HouseListViewModel>, UITableViewDelegate {
    
    let reuseIdentifier = "HouseListCell"
    let filterV = FilterView()
    let districtV = DistrictOptionView()
    let priceV = PriceOptionView()
    let styleV = StyleOptionView()
    let subwayV = SubwayOptionView()
    var filterState = FilterViewState.none {
        didSet{
            self.navigationItem.rightBarButtonItem?.isEnabled = filterState == .none
        }
    }
    var filterViews = [HouseOptionView]()
    let sortSlideV = SortSlideView()
    let errBgView = ErrorBackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HouseListViewModel()
        navigationItem.title = "所有房源"
        setUpViews()
        
        viewModel.requestData()
                
        viewModel.listSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: HouseListCell.self)) { row, model, cell in
            cell.house = model
        }.disposed(by: disposeBag)
        
        viewModel.listSource.asObservable().bind { (houseList) in
            if houseList.isEmpty {
                self.tableView.addSubview(self.errBgView)
            } else {
                self.errBgView.removeFromSuperview()
            }
        }.disposed(by: disposeBag)
        
        setUpEvents()
        filterViews = [districtV, priceV, styleV, subwayV]
        
    }
    
    func setUpViews() {
        let leftItem = UIBarButtonItem()
        leftItem.title = "上海"
        leftItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        navigationItem.leftBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem()
        rightItem.title = "排序"
        rightItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], for: .normal)
        navigationItem.rightBarButtonItem = rightItem
        rightItem.rx.tap.bind {
            self.sortSlideV.switchShowState()
        }.disposed(by: disposeBag)
        
        let searchV = CustomSearchView(frame: CGRect.init(x: 0, y: 0, width: Global.ScreenWidth, height: 50))
        searchV.hidesNavigationBarDuringPresentation = false
        searchV.backgroundColor = UIColor.hxf5f5f5
        searchV.isHidSystemBorder = true
        searchV.fieldHeight = 35
        let searchBar = searchV.searchBar
        searchBar?.placeholder = "请输入关键字"
        let searchBtn = UIButton()
        
        tableView.tableHeaderView = searchV
        searchV.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.edges.equalTo(searchV)
        }
        searchBtn.rx.tap.bind { [unowned self] in
            let searchVC = HouseSearchController()
            self.addChildViewController(searchVC)
            self.view.addSubview(searchVC.view)
        }.disposed(by: disposeBag)
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 0)
            self.districtV.collectionV.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            self.priceV.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.styleV.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.subwayV.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        view.addSubview(sortSlideV)
        
        errorBackgroudView.isHidden = true
        errBgView.frame = CGRect.init(x: 0, y: 95, width: view.bounds.width, height: view.bounds.height-95-(navigationController?.navigationBar.bounds.height ?? 0))
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        tableView.register(HouseListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = 45
        tableView.delegate = self
        
        tableView.rx.modelSelected(House.self).bind { [unowned self] (house) in
            self.toDetailVC(house.house_id.wrapSafely)
        }.disposed(by: disposeBag)
    }
    
    func setUpEvents() {
        
        filterV.collectionV.rx.itemSelected.bind { [unowned self] indexPath in
            self.tableView.setContentOffset(CGPoint(x: 0, y: 50), animated: false)
            self.tableView.snp.makeConstraints({ (make) in
                make
            })
            if indexPath.row == self.filterState.rawValue {
                self.filterViews[indexPath.row].removeFromSuperview()
                return
            }
            self.filterState = FilterViewState(rawValue: indexPath.row)!
            for (i, v) in self.filterViews.enumerated() {
                if i == indexPath.row {
                    self.view.addSubview(v)
                } else if v.superview != nil {
                    v.removeFromSuperview()
                }
            }
        }.disposed(by: disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.FilterViewDidRemoved).bind { [unowned self] noti in
            self.filterState = .none
            self.filterV.items.value = self.viewModel.filterCategories
        }.disposed(by: disposeBag)
        
        Observable.merge(districtV.collectionV.rx.itemSelected.asObservable(),
                         priceV.tableView.rx.itemSelected.asObservable(),
                         styleV.tableView.rx.itemSelected.asObservable(),
                         subwayV.tableView.rx.itemSelected.asObservable()).bind { [unowned self] (_) in
                            self.refreshListWithFilter()
        }.disposed(by: disposeBag)
        
        sortSlideV.tableView.rx.itemSelected.bind { [unowned self] indexPath in
            self.sortSlideV.dismiss()
            self.viewModel.sortType = HouseListViewModel.SortType(rawValue: indexPath.row)
            self.viewModel.pullDownRefresh()
        }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return filterV
    }
    
    func refreshListWithFilter() {
        let districtIndex = districtV.collectionV.indexPathsForSelectedItems?.first?.row ?? 0
        if districtIndex == 0 {
            viewModel.filterDistrict = nil
        } else {
            viewModel.filterDistrict = districtV.districts.value[districtIndex]
        }
        let priceIndex = priceV.tableView.indexPathForSelectedRow?.row ?? 0
        if priceIndex == 0 {
            viewModel.filterPriceRange = nil
        } else {
            viewModel.filterPriceRange = priceV.priceRanges.value[priceIndex]
        }
        let rentModeIndex = styleV.tableView.indexPathForSelectedRow?.row ?? 0
        if rentModeIndex == 0 {
            viewModel.filterRentType = nil
        } else {
            viewModel.filterRentType = House.RentType(rawValue: rentModeIndex)
        }
        let subwayIndex = subwayV.tableView.indexPathForSelectedRow?.row ?? 0
        if subwayIndex == 0 {
            viewModel.filterSubway = nil
        } else {
            viewModel.filterSubway = subwayV.subways.value[subwayIndex]
        }
        filterViews.forEach { (v) in
            v.removeFromSuperview()
        }
        viewModel.pullDownRefresh()
    }
}

enum FilterViewState: Int {
    case district
    case price
    case style
    case subway
    case none
}
