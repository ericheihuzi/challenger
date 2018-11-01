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
        
        cell.GameCover.backgroundColor = UIColorTemplates.colorFromString(rowDataModel.color)
        cell.GameLargeCellModel = rowDataModel
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        
        //登录判断
//        guard Defaults[.isLogin] == true else {
//            return PageJump.JumpToLogin(.present)
//        }
        
        RequestJudgeState.judgeTokenAccess() {
            // 显示loading
            CBToast.showToastAction()
            
            // 获取游戏数据
            let gameData = self.gameListVM.gameList[indexPath.row]
            
            let gameID = gameData.gameID
            let gameTitle = gameData.title
            let gameColor = gameData.color
            let category = gameData.category
            let level = gameData.level
            let coverName = gameData.coverName
            
            let GRES = gameData.rescore
            let GCAS = gameData.cascore
            let GINS = gameData.inscore
            let GMES = gameData.mescore
            let GSPS = gameData.spscore
            let GCRS = gameData.crscore
            let GS = [GRES,GCAS,GINS,GMES,GSPS,GCRS]
            
            // 请求用户数据
            self.userGameVM.loadUserGame(gameID) { dict2 in
                let userGameData = UserGameModel(dict: dict2)
                let userLevel = userGameData.level
                print("userLevel------\(userLevel)-----")
                let ranking = userGameData.ranking
                let rankingChange = userGameData.rankingChange
                let nickName = Defaults[.nickName]
                
                let URES = userGameData.rescore
                let UCAS = userGameData.cascore
                let UINS = userGameData.inscore
                let UMES = userGameData.mescore
                let USPS = userGameData.spscore
                let UCRS = userGameData.crscore
                let US = [URES,UCAS,UINS,UMES,USPS,UCRS]
                
                let senderData:[String:Any] = [
                    //游戏数据
                    "gameID": gameID,
                    "gameTitle": gameTitle,
                    "gameColor": gameColor,
                    "category": category,
                    "level": level,
                    "coverName": coverName,
                    "chartGS": GS,
                    "chartUS": US,
                    "GRES": GRES,
                    "GCAS": GCAS,
                    "GINS": GINS,
                    "GMES": GMES,
                    "GSPS": GSPS,
                    "GCRS": GCRS,
                    
                    //用户数据
                    "userLevel": userLevel,
                    "ranking": ranking,
                    "rankingChange": rankingChange,
                    "nickName": nickName ?? "",
                    "URES": URES,
                    "UCAS": UCAS,
                    "UINS": UINS,
                    "UMES": UMES,
                    "USPS": USPS,
                    "UCRS": UCRS
                ]
                
                // 隐藏loading
                CBToast.hiddenToastAction()
                
                self.performSegue(withIdentifier: "showGameBeforeSegue", sender: senderData)
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.ReceiveData = sender as! [String : Any]
        }
    }
    
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        // 显示loading
        CBToast.showToastAction()
        
        gameListVM.loadGameList{
            // 加载列表数据
            self.tableView.reloadData()
            
            // 隐藏loading
            CBToast.hiddenToastAction()
        }
    }
    
}

