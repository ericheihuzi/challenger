//
//  WebViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/11.
//  Copyright © 2018年 黑胡子. All rights reserved.
//
//github链接:https://github.com/XFIOSXiaoFeng/SwiftWkWebView

import UIKit
import WebKit

enum WebType {
    case normal
    case local
    case post
}

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WebView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    var titleStr: String? = "Title"
    var url: String? = ""
    var htmlName: String? = ""
    var parameters = [String : Any]()
    var type: WebType? = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        self.automaticallyAdjustsScrollViewInsets = false
        self.navTitle.title = titleStr ?? ""
        
        loadDate(type: type!, url: url!, htmlName: htmlName, parameters: parameters)
    }
    
    func loadDate(type: WebType, url: String? = nil, htmlName: String? = nil, parameters : [String : Any]? = nil) {
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        webView.delegate = self
        
        switch type {
        case .normal:
            // 加载普通URL
            webView.webConfig = config
            webView.webloadType(self, .URLString(url: url!))
        case .local:
            // 加载本地URL
            config.scriptMessageHandlerArray = ["valueName"]
            webView.webConfig = config
            webView.webloadType(self, .HTMLName(name: htmlName!))
        case .post:
            webView.webConfig = config
            webView.webloadType(self, .POST(url: url!, parameters: parameters!))
        }
    }
    
//    deinit {
//        webView.delegate = nil
//    }
    
    @IBAction func refreshClick(_ sender: UIBarButtonItem) {
        webView.reload()
        print("刷新页面")
    }
    
    @IBAction func close(_ sender: Any) -> Void {
        print("关闭web页")
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension WebViewController: WKWebViewDelegate {
    
    func webViewUserContentController(_ scriptMessageHandlerArray: [String], didReceive message: WKScriptMessage) {
        print(message.body)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("开始加载")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("开始获取网页内容")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("加载完成")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("加载失败")
    }
}
