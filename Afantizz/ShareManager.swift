//
//  ShareManager.swift
//  Afantizz
//
//  Created by yuanchao on 2018/3/27.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit

class ShareManager: NSObject, WXApiDelegate {
    
    class ShareConfigure: BaseModel {
        var title: String = ""
        var desc: String = ""
        var image: String = ""
        var thumbImage: UIImage?
        var webPageUrlStr = ""
        
        required init() {}
    
    }
    
    static let `default` = ShareManager()
    private override init() {}
    
    private lazy var shareSheetController: UIAlertController = {
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let sessionAction = UIAlertAction.init(title: "分享给微信好友", style:  .default, handler: { (_) in
            self.share(to: WXSceneSession)
        })
        let timelineAction = UIAlertAction.init(title: "分享到朋友圈", style: .default, handler: { (_) in
            self.share(to: WXSceneTimeline)
        })
        let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(sessionAction)
        alertController.addAction(timelineAction)
        alertController.addAction(cancelAction)
        return alertController
    }()
    
    var shareConfigre: ShareConfigure?
    
    func handleOpenURL(_ url: URL) {
        WXApi.handleOpen(url, delegate: self)
    }
    
    func onReq(_ req: BaseReq!) {
        
    }
    
    func onResp(_ resp: BaseResp!) {
        
    }
    
    class func share(invoker: UIViewController, configure: ShareConfigure) {
        self.default.shareConfigre = configure
        invoker.present(self.default.shareSheetController, animated: true) {
            
        }
    }
    
    func share(to type: WXScene) {
        guard let configure = shareConfigre,
              let img = configure.thumbImage else {
            return
        }
        let msg = WXMediaMessage()
        msg.title = configure.title
        msg.description = configure.desc
        msg.setThumbImage(img)
        
        let webPageObject = WXWebpageObject()
        webPageObject.webpageUrl = configure.webPageUrlStr
        msg.mediaObject = webPageObject
        
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = msg
        req.scene = Int32(type.rawValue)
        WXApi.send(req)
    }
    

}
