//
//  AboutTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class AboutTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 用户协议
    @IBAction func toUserProtocol(_ sender: Any) {
//        let wkSB2 = UIStoryboard(name: "WKWebView", bundle:nil)
//        let wkVC2 = wkSB2.instantiateViewController(withIdentifier: "WKWebViewController") as! WKWebViewController
        
        let webSB = UIStoryboard(name: "WebView", bundle:nil)
        let webVC = webSB.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webVC.titleStr = "用户服务协议"
        //webVC.type = .local
        webVC.url = "\(RequestHome)\(RequestUserProtocol)"
        //webVC.htmlName = "test"
        UIViewController.currentViewController()?.present(webVC, animated: true)
    }
    
    // 隐私政策
    @IBAction func toPrivacyPolicy(_ sender: Any) {
        let webSB = UIStoryboard(name: "WebView", bundle:nil)
        let webVC = webSB.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        webVC.titleStr = "隐私政策"
        webVC.url = "\(RequestHome)\(RequestUserPrivacy)"
        //UIViewController.currentViewController()?.navigationController?.pushViewController(webVC, animated: true)
        UIViewController.currentViewController()?.present(webVC, animated: true)
    }

}
