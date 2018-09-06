//
//  AllChallengeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let GameBigCell = "Cell"

class AllChallengeViewController: UITableViewController {
    @IBOutlet var contentTableView: UITableView!
    var isLogin = Defaults[.isLogin]
    // MARK: 懒加载属性
    fileprivate lazy var allChallengeVM : AllChallengeViewModel = AllChallengeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入*全部挑战*")
        
        //设置UI
        setupUI()
        
        //请求数据
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.isLogin = Defaults[.isLogin]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToAllChallengeViewController(_ sender: UIStoryboardSegue) { }
    
}

// MARK:- 设置UI界面
extension AllChallengeViewController {
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(UINib(nibName: "GameLargeTableViewCell", bundle: nil), forCellReuseIdentifier: GameBigCell)
    }
}

// MARK:- 遵守UITableView的协议
extension AllChallengeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChallengeVM.games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameBigCell, for: indexPath) as! GameLargeTableViewCell
        
        cell.GameLargeCellModel = allChallengeVM.games[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        //登录判断
        judgeIsLogin()
        
        //print("跳转到游戏详情页")
        let rowDataModel = allChallengeVM.games[indexPath.row]
        
        //设置图表属性
        Defaults[.chartViewDataColor] = rowDataModel.gameColor
            
        let gameID = rowDataModel.gameID
        //let gameChallengeType = rowDataModel.gameChallengeType
        
        print("--------------全部挑战")
        self.performSegue(withIdentifier: "showGameBeforeSegue", sender: gameID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.GameID = sender as? Int
        }
    }
    
}

extension AllChallengeViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        allChallengeVM.loadAllGameData {
            //self.contentTableView.reloadData()
        }
        
    }
    
    // MARK:- 若未登录，弹出登录界面
    fileprivate func judgeIsLogin() {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        
        if !isLogin {
            self.present(loginVC, animated: true)
        }
    }
    
}

