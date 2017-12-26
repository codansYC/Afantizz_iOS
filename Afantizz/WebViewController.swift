//
//  WebViewController.swift
//  Afantizz
//
//  Created by yuanchao on 2017/8/4.
//  Copyright © 2017年 lekuai. All rights reserved.
//

import UIKit
import NJKWebViewProgress

class WebViewController: BaseController, NJKWebViewProgressDelegate, UIWebViewDelegate {
    
    var isModal: Bool?
    var url: URL!
    
    let webView: UIWebView = {
        let v = UIWebView.init()
        v.backgroundColor = UIColor.colorWithRGB(r: 237, g: 239, b: 243)
        return v
    }()
    
    let titleView = WebTitleView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
    var progressProxy = NJKWebViewProgress.init()
    let progressView: NJKWebViewProgressView = {
        let p = NJKWebViewProgressView.init()
        p.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        p.progressBarView.backgroundColor = UIColor.colorWithRGB(r: 35, g: 236, b: 125)
        return p
    }()
    
    init(URLStr urlStr: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.hidesBottomBarWhenPushed = true
        self.url = URL(string: urlStr ?? "http") ?? URL(string: "http")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        loadWebPage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        progressView.removeFromSuperview()
    }
    
    func configureWebView() {
    
        webView.frame = view.bounds
        view.addSubview(webView)
        webView.scalesPageToFit = true
        
        let progressBarHeight: CGFloat = 2
        let navigationBarBounds = self.navigationController?.navigationBar.bounds ?? CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44)
        let barFrame = CGRect(x: 0, y: navigationBarBounds.size.height - progressBarHeight, width: navigationBarBounds.size.width, height: progressBarHeight)
        self.progressView.frame = barFrame
        navigationController?.navigationBar.addSubview(progressView)
        self.progressView.progress = 0
        
        self.webView.delegate = self.progressProxy
        self.progressProxy.webViewProxyDelegate = self
        self.progressProxy.progressDelegate = self
        
        if let modal = self.isModal, modal == true {
            let closeItem = UIBarButtonItem.init(image: UIImage.init(named: "quit"), style: .plain, target: self, action: #selector(closeItemPress))
            navigationItem.leftBarButtonItem = closeItem
        }
    }
    
    @objc func closeItemPress() {
        dismiss(animated: true, completion: nil)
    }
    
    func backBtnPress() {
        dismiss(animated: true, completion: nil)
    }
    
    func loadWebPage() {
        webView.loadRequest(URLRequest.init(url: url))
        
    }
    
    
    func webViewProgress(_ webViewProgress: NJKWebViewProgress!, updateProgress progress: Float) {
        progressView.setProgress(progress, animated: true)
        guard title == nil && navigationItem.title == nil else {
            return
        }
        let pageTitle = webView.stringByEvaluatingJavaScript(from: "document.title")
        titleView.title = pageTitle
        navigationItem.titleView = titleView
    }
    
}


class WebTitleView: BaseView {
    
    override var frame: CGRect {
        didSet {
            label?.frame = self.bounds
        }
    }
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label = UILabel.init(frame: self.bounds)
        self.label.textAlignment = .center
        self.label.font = UIFont.systemFont(ofSize: 17)
        self.label.textColor = UIColor.white
        self.addSubview(self.label)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
