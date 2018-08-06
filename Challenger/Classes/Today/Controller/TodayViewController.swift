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
    // 控件属性
    @IBOutlet weak var todayFreeChangeTableView: UITableView!
    @IBOutlet var contentTableView: UITableView!
    @IBOutlet var LoginButton: UIBarButtonItem!
    
    //获取登录状态
    var isLogin = Defaults[.isLogin]
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入今日")
        print("登录状态6：\(Defaults[.isLogin])")
        
        //设置UI界面
        setupUI()
        
        //请求数据
        
        //判断用户当前状态：是否登录
        loadStateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  Unwind action that is targeted by the demos which present a modal view
     *  controller, to return to the main screen.
     */
    @IBAction func unwindToTodayViewController(_ sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLoginSegue" {
            //Defaults[.isLogin] = false
            /*
            let controller = segue.destination as! LoginViewController
            controller.loginState { (login) in
                print(login)
                self.isLogin = login
                self.judgeIsLogin()
                self.loadStateUI()
            }
            */
        }
        
        print("登录状态7：\(Defaults[.isLogin])")
    }
    
}

// MARK:- 设置UI界面
extension TodayViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        
        //全局设置TableHeader
        //setupTableHeader()
        
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
    
    private func setupTableHeader() {
        //设置分区头尾的文字颜色：黑色
        //UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = UIColor.black
        //设置分区头尾的文字样式：14号粗体
        //UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).font = UIFont.boldSystemFont(ofSize: 14)
        //设置分区头尾的背景颜色：白色
        UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).backgroundColor = UIColor.white
    }
    
    private func loadStateUI() {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        
        // 若未登录，弹出登录界面
        if !isLogin {
            self.present(loginVC, animated: true)
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
