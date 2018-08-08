//
//  GameRankingTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/8.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let GameRankingCell = "Cell"

class GameRankingTableViewController: UITableViewController {
    
    //var GameID = Defaults[.rankingGameID]
    
    // MARK: 懒加载属性
    fileprivate lazy var gameRankingVM : GameRankingViewModel = GameRankingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("游戏ID：\(Defaults[.rankingGameID] ?? 0)----8")
        //print("游戏ID：\(GameID ?? 0)----4")
        // 请求数据
        loadData()

        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        self.tableView.register(UINib(nibName: "GameRankingTableViewCell", bundle: nil), forCellReuseIdentifier: GameRankingCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameRankingVM.gameRanking.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameRankingCell, for: indexPath) as! GameRankingTableViewCell
        
        cell.GameRankingListModel = gameRankingVM.gameRanking[indexPath.row]

        return cell
    }

}

extension GameRankingTableViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        //gameRankingVM.gameID = Defaults[.rankingGameID]
        gameRankingVM.loadGameRanking {}
    }
}
