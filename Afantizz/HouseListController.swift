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

class HouseListController: PagingController<House>, UITableViewDelegate {
    
    let reuseIdentifier = "HouseListCell"
    let filterV = FilterView()
    let districtV = DistrictOptionView()
    let priceV = PriceOptionView()
    let styleV = StyleOptionView()
    let subwayV = SubwayOptionView()
    var filterState = FilterViewState.none
    var filterViews = [HouseOptionView]()
    let houseListVM = HouseListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "所有房源"
        setUpViews()
        
        pagingVM = houseListVM
        houseListVM.requestData()
                
        houseListVM.listSource.asObservable().bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: HouseListCell.self)) { row, model, cell in
            cell.house = model
        }.addDisposableTo(disposeBag)
        
        setUpEvents()
        filterViews = [districtV, priceV, styleV, subwayV]
    }
    
    func setUpViews() {
        let searchV = CustomSearchView(frame: CGRect.init(x: 0, y: 0, width: Global.ScreenWidth, height: 50))
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
            self.tabBarController?.tabBar.isHidden = true
            self.addChildViewController(searchVC)
            self.view.addSubview(searchVC.view)
        }.addDisposableTo(disposeBag)
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(item: 0, section: 0)
            self.districtV.collectionV.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
            self.priceV.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.styleV.firstTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.styleV.secondTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            self.subwayV.tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)

        }
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        tableView.register(HouseListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.sectionHeaderHeight = 45
        tableView.delegate = self
        
        tableView.rx.modelSelected(House.self).bind { [unowned self] (house) in
            self.toDetailVC(house.house_id)
        }.addDisposableTo(disposeBag)
    }
    
    func setUpEvents() {
        filterV.collectionV.rx.itemSelected.bind { [unowned self] indexPath in
            self.tableView.setContentOffset(CGPoint(x: 0, y: 50), animated: false)
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
        }.addDisposableTo(disposeBag)
        
        NotificationCenter.default.rx.notification(Notification.Name.FilterViewDidRemoved).bind { [unowned self] noti in
            self.filterState = .none
            self.adjustFilterUI()
        }.addDisposableTo(disposeBag)
        
        districtV.collectionV.rx.modelSelected(String.self).asObservable().bind(onNext: { (district) in
            self.refreshListWithFilter()
        }).addDisposableTo(disposeBag)
        priceV.tableView.rx.modelSelected(String.self).asObservable().bind(onNext: { (price) in
            self.refreshListWithFilter()
        }).addDisposableTo(disposeBag)
        styleV.firstTableView.rx.modelSelected(String.self).asObservable().bind(onNext: { (rentMode) in
            if rentMode == Str.unlimited || rentMode == "公寓" {
                self.refreshListWithFilter()
            }
        }).addDisposableTo(disposeBag)
        styleV.secondTableView.rx.modelSelected(String.self).asObservable().bind(onNext: { (style) in
            self.refreshListWithFilter()
        }).addDisposableTo(disposeBag)
        subwayV.tableView.rx.modelSelected(String.self).asObservable().bind(onNext: { (subway) in
            self.refreshListWithFilter()
        }).addDisposableTo(disposeBag)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return filterV
    }
    
    func refreshListWithFilter() {
        let districIndex = districtV.collectionV.indexPathsForSelectedItems?.first?.row ?? 0
        houseListVM.district = districtV.items.value[districIndex]
        let priceIndex = priceV.tableView.indexPathForSelectedRow?.row ?? 0
        houseListVM.price = priceV.items.value[priceIndex]
        let rentModeIndex = styleV.firstTableView.indexPathForSelectedRow?.row ?? 0
        houseListVM.rentMode = styleV.items1.value[rentModeIndex]
        if let styleIndex = styleV.secondTableView.indexPathForSelectedRow?.row {
            houseListVM.style = styleV.items2.value[styleIndex]
        } else {
            houseListVM.style = Str.unlimited
        }
        let subwayIndex = subwayV.tableView.indexPathForSelectedRow?.row ?? 0
        houseListVM.subway = subwayV.items.value[subwayIndex]
        filterViews.forEach { (v) in
            v.removeFromSuperview()
        }
        houseListVM.pullDownRefresh()
        
    }
    
    func adjustFilterUI() {
        var filterVStyle = "户型"
        if houseListVM.rentMode != Str.unlimited {
            filterVStyle = houseListVM.rentMode
            if houseListVM.rentMode != "公寓" && houseListVM.style != Str.unlimited {
                filterVStyle += houseListVM.style
            }
        }
        filterV.items.value = [houseListVM.district == Str.unlimited ? "区域" : houseListVM.district,
                               houseListVM.price == Str.unlimited ? "租金" : houseListVM.price,
                               filterVStyle,
                               houseListVM.subway == Str.unlimited ? "地铁" : houseListVM.subway]
        styleV.firstTableView.selectRow(at: IndexPath.init(row: styleV.items1.value.index(of: houseListVM.rentMode) ?? 0, section: 0), animated: false, scrollPosition: .none)
        styleV.showSecondTableView(show: houseListVM.rentMode != Str.unlimited && houseListVM.rentMode != "公寓")
        styleV.secondTableView.selectRow(at: IndexPath.init(row: styleV.items2.value.index(of: houseListVM.style) ?? 0, section: 0), animated: false, scrollPosition: .none)
    }
}

enum FilterViewState: Int {
    case district
    case price
    case style
    case subway
    case none
}
