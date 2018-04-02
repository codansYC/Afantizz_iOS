//
//  LoginController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/9.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginController: BaseVMController<LoginViewModel> {

    var phoneField: UITextField!
    var codeField: UITextField!
    var sendCodeBtn: UIButton!
    var loginBtn: UIButton!
    var closeItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "登录"
        setUpViews()
        setUpEvent()
    }
    
    func setUpViews() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"quit")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(close))
        phoneField = UITextField()
        phoneField.placeholder = "请输入手机号"
        phoneField.clearButtonMode = .whileEditing
        view.addSubview(phoneField)
        phoneField.snp.makeConstraints { (make) in
            make.top.equalTo(120)
            make.centerX.equalTo(view)
            make.width.equalTo(270)
            make.height.equalTo(34)
        }
        
        let line1 = UIView()
        line1.backgroundColor = UIColor.hxedeff3
        view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.right.equalTo(phoneField)
            make.top.equalTo(phoneField.snp.bottom)
            make.height.equalTo(1)
        }
        
        codeField = UITextField()
        codeField.placeholder = "请输入验证码"
        codeField.clearButtonMode = .whileEditing
        view.addSubview(codeField)
        codeField.snp.makeConstraints { (make) in
            make.top.equalTo(line1.snp.bottom).offset(35)
            make.left.equalTo(phoneField)
        }
        
        sendCodeBtn = UIButton()
        sendCodeBtn.setTitle("获取验证码", for: .normal)
        sendCodeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        sendCodeBtn.setTitleColor(UIColor.hx34c86c, for: .normal)
        sendCodeBtn.setTitleColor(UIColor.hx888b9a, for: .disabled)
        sendCodeBtn.contentMode = .right
        view.addSubview(sendCodeBtn)
        sendCodeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(codeField.snp.right)
            make.right.equalTo(phoneField)
            make.width.equalTo(100)
            make.centerY.equalTo(codeField)
        }
        
        let line2 = UIView()
        line2.backgroundColor = UIColor.hxedeff3
        view.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.top.equalTo(codeField.snp.bottom)
            make.left.right.height.equalTo(line1)
        }
        
        loginBtn = UIButton()
        loginBtn.backgroundColor = UIColor.hx888b9a
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.layer.cornerRadius = 4
        view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints { (make) in
            make.left.right.equalTo(line2)
            make.height.equalTo(40)
            make.top.equalTo(line2.snp.bottom).offset(70)
        }
    }
    
    func setUpEvent() {
        let phoneObservable = phoneField.rx.text.map{ txt in Global.validateMobile(txt) }.asObservable()
        let codeObservable = codeField.rx.text.map{ txt in Global.validateCaptcha(txt) }.asObservable()
        
        Observable.combineLatest(
            phoneObservable,
            viewModel.isCounting.asObservable()).map({ (isPhone, isCounting) -> Bool in
                return isPhone && !isCounting
            })
            .bind(to: sendCodeBtn.rx.isEnabled)
        .disposed(by: disposeBag)
            
        sendCodeBtn.rx.tap.bind { [unowned self] _ in
            let phone = self.phoneField.text
            if !Global.validateMobile(phone) {
                self.show("手机号不正确")
                return
            }
            self.showLoading()
            self.viewModel.getCode(phone: phone!) { [weak self] in
                guard let this = self else { return }
                this.viewModel.countDown().bind(to: this.sendCodeBtn.rx.title()).disposed(by: this.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        Observable.combineLatest(phoneObservable,codeObservable).map { (isPhone, isCaptcha) -> Bool in
            return isPhone && isCaptcha
        }.bind { (isEnable) in
            self.loginBtn.isEnabled = isEnable
            self.loginBtn.backgroundColor = isEnable ? UIColor.hx34c86c : UIColor.hx888b9a
        }.disposed(by: disposeBag)
    
        loginBtn.rx.tap.bind { [unowned self] _ in
            self.phoneField.resignFirstResponder()
            let phone = self.phoneField.text
            let code = self.codeField.text
            if !Global.validateMobile(phone) {
                self.show("手机号不正确")
                return
            }
            if !Global.validateCaptcha(code) {
                self.show("验证码不正确")
                return
            }
            self.showLoading("登录中...")
            self.viewModel.login(phone: phone!, code: code!) { [weak self] in
                self?.resetHud(mode: .text, text: "登录成功")
                self?.hideHud(afterDelay: 1) {
                    self?.navigationController?.dismiss(animated: true, completion: nil)
                }
            }
        }.disposed(by: disposeBag)
    }
    
    @objc func close() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
