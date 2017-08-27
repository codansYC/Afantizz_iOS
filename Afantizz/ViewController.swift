//
//  ViewController.swift
//  Afantizz
//
//  Created by lekuai on 2017/7/10.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import HandyJSON
import SDWebImage

class ViewController: PagingController<House>, UITableViewDelegate,UITableViewDataSource {
    
    var houses: [House?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        
        pagingVM = HouseListViewModel()
        pagingVM?.requestData()
        pagingVM?.listSource.asObservable().bind(onNext: { (houses) in
            self.houses = houses
            self.tableView.reloadData()
        }).addDisposableTo(disposeBag)
    }
    
    
    //MARK: -- tableView delegate dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return houses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        if let images = houses[indexPath.row]?.images, !images.isEmpty {
//            let url = URL(string: images[0].thumb_url!)
//            cell.imageView?.sd_setImage(with: url)
//        }
        cell.textLabel?.text = houses[indexPath.row]?.price
        return cell
    }
}





