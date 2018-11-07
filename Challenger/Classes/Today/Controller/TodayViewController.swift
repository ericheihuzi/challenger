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
    @IBOutlet var newDataView: NewDataView!
    
    // MARK: 懒加载属性
    fileprivate lazy var newDataVM : ChallengeInfoViewModel = ChallengeInfoViewModel()
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //加载数据
        loadData()
        
        //初始化刷新
        initalRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入今日")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 刷新数据
    @objc func refreshData() {
        // 移除老数据
        //self.gameListVM.gameList.removeAll()
        // 加载新数据
        self.loadData()
        // 结束刷新
        self.refreshControl!.endRefreshing()
    }
    
    @IBAction func unwindToTodayViewController(_ sender: UIStoryboardSegue) {}
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showLoginSegue" {
//        }
//    }
    
}

extension TodayViewController {
    private func setupUI() {
        // 设置导航栏
        setupNavigationBar()
        
        // 根据登录状态设置相关页面属性
        judgeIsLogin()
        
    }
    
    private func initalRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.gray //菊花的颜色
        //self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
    }
    
    // MARK:- 网络数据请求
    private func loadData() {
        newDataVM.loadChallengeTime{ time in
            let challengeTime = time as! Int
            let todayRanking = Defaults[.todayRanking] ?? 0
            let rankingChange = 0
            self.newDataView.loadNewData(challengeTime,todayRanking,rankingChange)
        }
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
        LoginButton.isEnabled = false
        
        /*
        if Defaults[.isLogin] {
            // 设置已登录状态的UI
            LoginButton.isEnabled = false
        } else {
            // 设置已登录状态的UI
            LoginButton.isEnabled = true
        }
        */
    }
    
}
