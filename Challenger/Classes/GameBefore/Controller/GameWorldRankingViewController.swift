//
//  GameWorldRankingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/23.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let GameRankingCell = "Cell"

class GameWorldRankingViewController: UIViewController {
    
    // MARK: 懒加载属性
    //fileprivate lazy var rankingVM : GameRankingViewModel = GameRankingViewModel()
    
    @IBOutlet var rankingTableView: UITableView!
    
    var GameID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 请求数据
        loadGameRankingData()
        
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.register(UINib(nibName: "GameRankingTableViewCell", bundle: nil), forCellReuseIdentifier: GameRankingCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension GameWorldRankingViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = 0//rankingVM.gameRanking.count
        if count <= 4 {
            return count
        } else {
            return 4
        }
        //return //rankingVM.gameRanking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Ccell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameRankingCell, for: indexPath) as! GameRankingTableViewCell
        
//        cell.GameRankingListModel = rankingVM.gameRanking[indexPath.row]
        
        return cell
    }
    
}

extension GameWorldRankingViewController {
    // MARK:- 网络数据请求
    fileprivate func loadGameRankingData() {
        //rankingVM.gameID = self.GameID!
        //rankingVM.loadGameRanking {
//        }
    }

}
