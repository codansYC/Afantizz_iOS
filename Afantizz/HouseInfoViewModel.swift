//
//  HouseInfoViewModel.swift
//  Afantizz
//
//  Created by yuanchao on 2018/3/28.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class HouseInfoViewModel: BaseViewModel {
    
    var houseId = ""
    var shareConfigure: ShareManager.ShareConfigure?
    func requestShareConfigure(success: @escaping ()->Void) {
        ShareManager.ShareConfigure.request(url: "/house/share", params: ["house_id" : houseId], success: { (configure) in
            self.shareConfigure = configure
            self.urlToImage {
                success()
            }
        }, error: { (error) in
            self.requestFail(error)
        }) {
            self.requestFailWithNetworkPoor()
        }
    }
    
    func urlToImage(complete: @escaping (()->Void)) {
        
        DispatchQueue.global().async {
            guard let str = self.shareConfigure?.image, let url = URL.init(string: str) else {
                DispatchQueue.main.async {
                    complete()
                }
                return
            }
            guard let data = try? Data.init(contentsOf: url, options: Data.ReadingOptions.mappedIfSafe) else {
                DispatchQueue.main.async {
                    complete()
                }
                return
            }
            
            self.shareConfigure?.thumbImage = UIImage.init(data: data)
            DispatchQueue.main.async {
                complete()
            }
        }
    }
}

