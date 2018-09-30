//
//  TodayViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/3.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

@IBDesignable
class TodayViewController: UITableViewController {
    // MARK: - 控件属性
    @IBOutlet weak var todayFreeChangeTableView: UITableView!
    @IBOutlet var contentTableView: UITableView!
    @IBOutlet var LoginButton: UIBarButtonItem!
    
    // 获取登录状态
    var isLogin = Defaults[.isLogin]
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入今日")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToTodayViewController(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLoginSegue" {
        }
    }
    
}

// MARK:- 设置UI界面
extension TodayViewController {
    private func setupUI() {
        // 设置导航栏
        setupNavigationBar()
        
        // 根据登录状态设置相关页面属性
        judgeIsLogin()
        
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        // 设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        // 设置今日时间
        let date = Date()
        let timeZone = NSTimeZone.system
        let dateformatter = DateFormatter()
        dateformatter.timeZone = timeZone
        dateformatter.dateFormat = "MM月dd日 EEEE"
        let strNowTime = dateformatter.string(from: date)
        LoginButton.title = strNowTime
    }
    
    private func judgeIsLogin() {
        if isLogin {
            // 设置已登录状态的UI
            LoginButton.isEnabled = false
        } else {
            // 设置已登录状态的UI
            //LoginButton.isEnabled = true
            LoginButton.isEnabled = false
        }
    }
    
}
