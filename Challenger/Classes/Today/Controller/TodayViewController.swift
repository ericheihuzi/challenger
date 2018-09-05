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
    
    // MARK: - 懒加载属性
    fileprivate lazy var userInfoVM : UserInfoViewModel = UserInfoViewModel()
    
    // 获取登录状态
    var isLogin = Defaults[.isLogin]
    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入今日")
        print("登录状态6：\(Defaults[.isLogin])")
        
        //设置UI界面
        setupUI()
        
        //判断用户登录状态
        loadStateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("显示今日啦")
        let newDataView = NewDataView()
        newDataView.loadNewDataView()
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
        //设置导航栏
        setupNavigationBar()
        
        //根据登录状态设置相关页面属性
        judgeIsLogin()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func loadStateUI() {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        
        // 若未登录，弹出登录界面
        if !isLogin {
            self.present(loginVC, animated: true)
        } else {
            //请求userInfo
            userInfoVM.loadUserInfo {
                self.judgeInfo(self.userInfoVM.loadStatusValue!)
            }
        }
    }
    
    private func judgeInfo(_ status: Int) {
        let infoSB = UIStoryboard(name: "AddUserInfo", bundle:nil)
        let infoVC = infoSB.instantiateViewController(withIdentifier: "AddUserInfoViewController") as! AddUserInfoViewController
        // status: 1用户信息不存在，0获取成功
        if status != 0 {
            print("---->即将弹出完善信息页")
            // 弹出完善用户信息页
            self.present(infoVC, animated: true)
            print("---->已弹出完善信息页")
        } else {
            print("------ 登录成功 ------")
            Defaults[.isLogin] = true
        }
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
