//
//  ErrorBackgroundView.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/4.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ErrorBackgroundView: UIView {

    var btnTitle = "刷新" {
        didSet{
            refreshBtn?.setTitle(btnTitle, for: .normal)
        }
    }
    var desc = "暂无数据" {
        didSet{
            descLabel?.text = desc
        }
    }
    var img = UIImage(named: "error-no-data") {
        didSet{
            imgV.image = img
        }
    }
    
    var buttonClickClosure: (()->Void)?
    
    var refreshBtn: UIButton?
    var imgV: UIImageView!
    var descLabel: UILabel?
    
    let disposeBag = DisposeBag()
    
    var errorStyle = Variable(ErrorBackgroundViewStyle.noError)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setUpViews()
        handleEvents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        imgV = UIImageView(image: img)
        addSubview(imgV!)
        imgV.snp.makeConstraints({ (make) in
            make.top.equalTo(130)
            make.centerX.equalTo(self)
        })
    }
    
    func handleEvents() {
        errorStyle.asObservable().bind { [unowned self] (style) in
            switch style {
            case .noError:
                if self.superview != nil {
                    self.removeFromSuperview()
                }
            case .noData:
                self.showNoDataUI()
            case .noWifi:
                self.showNoWifiUI()
            }
            }.disposed(by: disposeBag)
    }
    
    func showNoDataUI() {
        if refreshBtn?.superview != nil {
            refreshBtn?.removeFromSuperview()
        }
        
        if descLabel?.superview == self {
            return
        }
        
        if descLabel == nil {
            descLabel = UILabel()
            descLabel?.text = desc
            descLabel?.textColor = UIColor.hx34c86c
            descLabel?.font = UIFont.systemFont(ofSize: 15)
        }
        
        addSubview(descLabel!)
        descLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(imgV)
            make.top.equalTo(imgV.snp.bottom).offset(20)
        })
    }
    
    func showNoWifiUI() {
        if descLabel?.superview != nil {
            descLabel?.removeFromSuperview()
        }
        
        if refreshBtn?.superview == self {
            return
        }
        
        if refreshBtn == nil {
            refreshBtn = UIButton()
            refreshBtn?.setTitle(btnTitle, for: .normal)
            refreshBtn?.setTitleColor(UIColor.white, for: .normal)
            refreshBtn?.backgroundColor = UIColor.hx34c86c
            refreshBtn?.layer.cornerRadius = 4
            refreshBtn?.contentEdgeInsets = UIEdgeInsetsMake(3, 10, 3, 10)
            refreshBtn?.rx.tap.bind { [unowned self] _ in
                self.buttonClickClosure?()
            }.disposed(by: disposeBag)
        }
        
        addSubview(refreshBtn!)
        refreshBtn?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(imgV)
            make.top.equalTo(imgV.snp.bottom).offset(20)
            
        })
    }
    
    func show(view: UIView, style: ErrorBackgroundViewStyle,buttonClick: (()->Void)? = nil) {
        if superview == view {
            return
        }
        removeFromSuperview()
        view.addSubview(self)
        frame = CGRect.init(origin: .zero, size: view.bounds.size)
        errorStyle.value = style

        buttonClickClosure = buttonClick
    }
    
}


enum ErrorBackgroundViewStyle: Int {
    case noData
    case noWifi
    case noError
}
