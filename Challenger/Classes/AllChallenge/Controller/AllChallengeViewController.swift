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
    //fileprivate lazy var gameListVM : AllChallengeViewModel = AllChallengeViewModel()
    fileprivate lazy var gameListVM : GameViewModel = GameViewModel()
    fileprivate lazy var userGameVM : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入全部挑战")
        
        // 显示loading
        CBToast.showToastAction()
        
        // 请求数据
        loadData()
        
        // 设置UI
        setupUI()
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
        return gameListVM.gameList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameBigCell, for: indexPath) as! GameLargeTableViewCell
        
        cell.GameLargeCellModel = gameListVM.gameList[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        //登录判断
        judgeIsLogin()
        
        // 显示loading
        CBToast.showToastAction()
        
        //print("跳转到游戏详情页")
        let rowDataModel = gameListVM.gameList[indexPath.row]
        
        let gameID = rowDataModel.gameID
        //print("gameID = \(gameID)")
        
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
        
        //设置图表属性
        //Defaults[.chartViewDataColor] = rowDataModel.color
        
        //self.performSegue(withIdentifier: "showGameBeforeSegue", sender: senderData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            //controller.GameID = sender as! String
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
    
    // MARK:- 若未登录，弹出登录界面
    fileprivate func judgeIsLogin() {
        if !isLogin {
            PageJump.JumpToLogin(.present)
        }
    }
    
}

