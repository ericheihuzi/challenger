//
//  GameRankingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/28.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let GameRankingCell = "Cell"

class GameRankingViewController: UIViewController {
    
    var GameID: String?
    
    @IBOutlet var rankingTableView: UITableView!
    // MARK: 懒加载属性
    fileprivate lazy var gameRankingVM : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 请求数据
        loadData()
        
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        self.rankingTableView.register(UINib(nibName: "GameRankingTableViewCell", bundle: nil), forCellReuseIdentifier: GameRankingCell)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
   
    
}

extension GameRankingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameRankingVM.gameRanking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameRankingCell, for: indexPath) as! GameRankingTableViewCell
        
        let ranking = indexPath.row + 1
        cell.RankingTagLabel.text = "\(ranking)"
        cell.GameRankingListModel = gameRankingVM.gameRanking[indexPath.row]
        
        let userID = gameRankingVM.gameRanking[indexPath.row].userID as String
        if Defaults[.userID] == userID {
            cell.NickNameLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        }
        
        if ranking == 1 {
            cell.MedalImageView.image = UIImage(named: "icon_medal_a")
            cell.RankingTagLabel.textColor = Theme.TextColor_ranking_1
        } else if ranking == 2 {
            cell.MedalImageView.image = UIImage(named: "icon_medal_b")
            cell.RankingTagLabel.textColor = Theme.TextColor_ranking_2
        } else if ranking == 3 {
            cell.MedalImageView.image = UIImage(named: "icon_medal_c")
            cell.RankingTagLabel.textColor = Theme.TextColor_ranking_3
        } else {
            cell.MedalImageView.isHidden = true
            cell.RankingTagLabel.font = UIFont(name: "PingFangSC-Medium", size: 14)
            cell.RankingTagLabel.textColor = Theme.TextColor_ranking_4
        }
        
        return cell
    }
    
}

extension GameRankingViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        let gameID = GameID ?? ""
        gameRankingVM.loadGameRanking(gameID) {
            self.rankingTableView.reloadData()
        }
    }
}
