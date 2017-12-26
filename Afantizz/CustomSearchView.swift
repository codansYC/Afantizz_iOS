//
//  CustomSearchView.swift
//  LikingManager
//
//  Created by lekuai on 17/3/10.
//  Copyright © 2017年 LikingFit. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

//自定义的搜索视图

class CustomSearchView: UIView,UISearchBarDelegate {
    
    var hidesNavigationBarDuringPresentation = true
    var obscuresBackgroundView: UIView?
    var isShowObscuresBackground = true {
        didSet{
            if isShowObscuresBackground {
                if obscuresBackgroundView == nil {
                    initObscuresBackgroundView()
                }
            } else {
                obscuresBackgroundView = nil
            }
        }
    }

    var activeState = Variable(false)
    var isAnimating = false
    var isActive: Bool {
        return activeState.value
    }

    var updateSearchResults: ((CustomSearchView)->Void)?
    var searchBtnClick: ((CustomSearchView)->Void)?
    weak var ownerVC: UIViewController?
    weak var invokerNaviVC: UINavigationController?
    var searchBar: UISearchBar!
    var isHidSystemBorder = false
    var fieldHeight: CGFloat = 28
    var cancelBtn = UIButton()
    var fieldBorderWidth: CGFloat = 1
    var fieldBorderColor = UIColor.hxedeff3.cgColor
    var fieldCornerRadius: CGFloat = 5
    var isShowCancelButtonWhenEdit = true
    var originBounds = CGRect.zero
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init() {
        super.init(frame: CGRect.init(x: 0, y: 0, width: Global.ScreenWidth, height: 50))
        commonInit()
    }
    
    func commonInit() {
        searchBar = UISearchBar(frame: self.bounds)
        searchBar.delegate = self
        addSubview(searchBar)
        initObscuresBackgroundView()
        originBounds = self.bounds
    }
    
    func initObscuresBackgroundView() {
    
        obscuresBackgroundView = UIView.init(frame: UIScreen.main.bounds)
        obscuresBackgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        obscuresBackgroundView?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(slideDown)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        slideUp()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        keepCancelButtonEnable()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        slideDown()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if isShowObscuresBackground {
            if searchText.isEmpty {
                guard let obscuresBackgroundView = obscuresBackgroundView else { return }
                ownerVC?.view.addSubview(obscuresBackgroundView)
                if obscuresBackgroundView.superview == nil {
                    obscuresBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                }
            } else {
                self.obscuresBackgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0)
                self.obscuresBackgroundView?.removeFromSuperview()
            }
            
        }
        updateSearchResults?(self)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBtnClick?(self)
    }
    
    func slideUp() {
        
        searchBar.becomeFirstResponder()
        if isActive { return }
        
        if let obscuresBackgroundView = obscuresBackgroundView {
            if obscuresBackgroundView.superview == nil {
                ownerVC?.view.addSubview(obscuresBackgroundView)
            }
        }
        
        if isShowCancelButtonWhenEdit {
            searchBar.setShowsCancelButton(true, animated: true)
            let btn = self.searchBar.value(forKey: "_cancelButton") as! UIButton
            btn.setTitle(self.cancelBtn.currentTitle, for: .normal)
            btn.setTitleColor(self.cancelBtn.currentTitleColor, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: self.cancelBtn.titleLabel?.font.pointSize ?? 15)
            self.cancelBtn = btn
        }
        
        isAnimating = true
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration), animations: {
            if self.hidesNavigationBarDuringPresentation {
                self.frame.size.height += 20
                self.searchBar.frame.origin.y += 20
            }
            self.obscuresBackgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        }) { flag in
            self.isAnimating = false
            self.updateSearchResults?(self)
            self.activeState.value = true
        }
        
        if hidesNavigationBarDuringPresentation {
            invokerNaviVC?.setNavigationBarHidden(true, animated: true)
            UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.default, animated: true)
        }
    }
    
    @objc func slideDown() {
        
        if !isActive { return }
        
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        isAnimating = true
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration), animations: {
            if self.hidesNavigationBarDuringPresentation {
                self.frame.size.height -= 20
                self.searchBar.frame.origin.y -= 20
            }
            self.obscuresBackgroundView?.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        }) { (flag) in
            self.isAnimating = false
            self.activeState.value = false

            self.obscuresBackgroundView?.removeFromSuperview()
            self.updateSearchResults?(self)
            
        }
        invokerNaviVC?.setNavigationBarHidden(false, animated: true)
        searchBar.resignFirstResponder()
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
        
    }
    
    override func layoutSubviews() {
        searchBar.subviews.first?.subviews.forEach({ (v) in
            if v.classForCoder == NSClassFromString("UISearchBarBackground") {
                v.alpha = isHidSystemBorder ? 0 : 1
            } else if let field = v as? UITextField {
                DispatchQueue.main.async {
                    self.setUpTextField(field: field)
                }
            }
        })
        
    }
    
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        if newSuperview == nil {
            return
        }
        
        ownerVC = newSuperview!.viewController()
        invokerNaviVC = invokerNaviVC ?? ownerVC?.navigationController
    }
    
    func setUpTextField(field: UITextField) {
        let layer = field.layer
        layer.borderColor = fieldBorderColor
        layer.borderWidth = fieldBorderWidth
        layer.cornerRadius = fieldCornerRadius
        layer.masksToBounds = true
        field.frame.size.height = self.fieldHeight
        field.frame.origin.y = (self.originBounds.height - self.fieldHeight) / 2
    }
    
    func keepCancelButtonEnable() {
        
        searchBar.subviews.first?.subviews.forEach({ (v) in
            if let cancelBtn = v as? UIButton {
                DispatchQueue.main.async {
                    cancelBtn.isEnabled = true
                }
            }
        })
    }

}

