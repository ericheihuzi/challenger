//
//  TodayViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/3.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit



@IBDesignable
class TodayViewController: UITableViewController {
    
    @IBOutlet weak var todayFreeChangeTableView: UITableView!
    @IBOutlet var contentTableView: UITableView!
    
    //MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  Unwind action that is targeted by the demos which present a modal view
     *  controller, to return to the main screen.
     */
    @IBAction func unwindToTodayViewController(_ sender: UIStoryboardSegue) { }
    
}

// MARK:- 设置UI界面
extension TodayViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        
        //全局设置TableHeader
        //setupTableHeader()
        
    }
    private func setupNavigationBar() {
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
}
