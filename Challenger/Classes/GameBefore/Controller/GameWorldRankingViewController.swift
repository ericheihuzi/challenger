//
//  GameWorldRankingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/23.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let GameRankingCell = "Cell"

class GameWorldRankingViewController: UIViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var rankingVM : GameViewModel = GameViewModel()
    
    @IBOutlet var rankingTableView: UITableView!
    @IBOutlet var UserRankingLabel: UILabel! //显示用户排名
    @IBOutlet var UserHeadImageView: UIImageView!
    
    var GameID: String = ""
    var UserGameRanking: Int = 0
    var UserRankingText: String = "" //用户描述
    var gameColor: String = ""
    var nickName: String = ""
    var rankingChange: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.register(UINib(nibName: "GameRankingTableViewCell", bundle: nil), forCellReuseIdentifier: GameRankingCell)
        
        // 请求数据
        loadGameRankingData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension GameWorldRankingViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = rankingVM.gameRanking.count
        if count <= 4 {
            return count
        } else {
            return 4
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameRankingCell, for: indexPath) as! GameRankingTableViewCell
        
        let userID = rankingVM.gameRanking[indexPath.row].userID as String
        if Defaults[.userID] == userID {
            self.UserGameRanking = indexPath.row + 1
            print("用户等级 = \(UserGameRanking)")
            //self.UserRankingLabel.text = UserRankingText + "\(UserGameRanking)" + "，继续加油哦！"
        }
        
        cell.RankingTagLabel.text = "\(indexPath.row + 1)"
        cell.GameRankingListModel = rankingVM.gameRanking[indexPath.row]
        
        return cell
    }
    
}

extension GameWorldRankingViewController {
    
    fileprivate func loadRankingDes() {
        // 设置头像
        //拼接头像路径
        let headPath = "\(RequestHome)\(RequestUserHeadImage)"
        let headImageURL = URL(string: headPath + Defaults[.picName]!)
        
        if Defaults[.sex] == 2 {
            self.UserHeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
        } else {
            self.UserHeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
        }
        
        // 设置用户标语
        judgeUserRankingText()
        let textColor = UIColorTemplates.colorFromString(gameColor)
        self.UserRankingLabel.textColor = textColor
        self.UserRankingLabel.text = UserRankingText + "\(UserGameRanking)" + "，继续加油哦！"
    }
    
    // 根据排名变化判断描述
    fileprivate func judgeUserRankingText() {
        if rankingChange < 0 {
            let change1 = abs(rankingChange)
            self.UserRankingText = "很遗憾~ " + nickName + "，你的排名下降了\(change1)个名次，现在的排名是"
        } else if rankingChange > 0 {
            let change2 = abs(rankingChange)
            self.UserRankingText = "太棒了！" + nickName + "，你的排名上升了\(change2)个名次，现在的排名是"
        } else {
            self.UserRankingText = "太棒了！" + nickName + "，当前排名"
        }
    }
    
    // MARK:- 网络数据请求
    fileprivate func loadGameRankingData() {
        rankingVM.loadGameRanking(GameID) {
            self.rankingTableView.reloadData()
            self.loadRankingDes()
        }
    }

}
