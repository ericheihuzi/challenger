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
    
    // MARK: 懒加载属性
    fileprivate lazy var gameListVM : GameViewModel = GameViewModel()
    fileprivate lazy var userGameVM : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 显示loading
        CBToast.showToastAction()
        
        // 设置UI
        setupUI()
        
        //初始化刷新
        initalRefresh()
        
        // 请求数据
        refreshData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入全部挑战")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 刷新数据
    @objc func refreshData() {
        // 移除老数据
        self.gameListVM.gameList.removeAll()
        // 加载新数据
        self.loadData()
        // 结束刷新
        self.refreshControl!.endRefreshing()
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
    
    private func initalRefresh() {
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl?.tintColor = UIColor.gray //菊花的颜色
        //self.refreshControl?.attributedTitle = NSAttributedString(string: "下拉刷新")
    }
}

// MARK:- 遵守UITableView的协议
extension AllChallengeViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameListVM.gameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameBigCell, for: indexPath) as! GameLargeTableViewCell
        
        let rowDataModel = gameListVM.gameList[indexPath.row]
        
        let gameID = rowDataModel.gameID
        
        gameListVM.loadGameJoin(gameID) { join in
            cell.PeopleNum.text = "\(join)人参与"
        }
        
        cell.GameLargeCellModel = rowDataModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        
        //登录判断
        guard Defaults[.isLogin] == true else {
            return PageJump.JumpToLogin(.present)
        }
        
        // 显示loading
        CBToast.showToastAction()
        
        //print("跳转到游戏详情页")
        let rowDataModel = gameListVM.gameList[indexPath.row]
        
        let gameID = rowDataModel.gameID
        
        // 请求用户游戏数据
        self.userGameVM.loadUserGame(gameID) { dict2 in
            let userGameData = UserGameModel(dict: dict2)
            
            let URES = userGameData.rescore
            let UCAS = userGameData.cascore
            let UINS = userGameData.inscore
            let UMES = userGameData.mescore
            let USPS = userGameData.spscore
            let UCRS = userGameData.crscore
            let US = [URES,UCAS,UINS,UMES,USPS,UCRS]
            
            let GRES = rowDataModel.rescore
            let GCAS = rowDataModel.cascore
            let GINS = rowDataModel.inscore
            let GMES = rowDataModel.mescore
            let GSPS = rowDataModel.spscore
            let GCRS = rowDataModel.crscore
            let GS = [GRES,GCAS,GINS,GMES,GSPS,GCRS]
            
            let senderData:[String:Any] = [
                "gameID": rowDataModel.gameID,
                "gameColor": rowDataModel.color,
                "chartGS": GS,
                "chartUS": US
            ]
            
            // 隐藏loading
            CBToast.hiddenToastAction()
            
            self.performSegue(withIdentifier: "showGameBeforeSegue", sender: senderData)
        }
        
        //self.performSegue(withIdentifier: "showGameBeforeSegue", sender: senderData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.ReceiveData = sender as! [String : Any]
        }
    }
    
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        gameListVM.loadGameList{
            // 加载列表数据
            self.tableView.reloadData()
            
            // 隐藏loading
            CBToast.hiddenToastAction()
        }
    }
    
}

