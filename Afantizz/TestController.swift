//
//  TestController.swift
//  Afantizz
//
//  Created by yuanchao on 2018/1/29.
//  Copyright © 2018年 lekuai. All rights reserved.
//

import UIKit
import WebKit

class TestController: UIViewController,WKNavigationDelegate, WKUIDelegate {

    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.load(URLRequest.init(url: URL.init(string: "http://www.afantizz1.com")!))
        
    }
    
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("\(#function)")
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("\(#function)")
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("\(#function)")
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("\(#function)")
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("\(#function)")
    }
    
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#function)")
    }
}
