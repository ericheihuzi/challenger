//
//  RankingTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/3.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let RankingCell = "Cell"

class RankingTableViewController: UITableViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var rankingVM : ChallengeInfoViewModel = ChallengeInfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        //加载数据
        loadData()
        
        self.tableView.register(UINib(nibName: "RankingListViewCell", bundle: nil), forCellReuseIdentifier: RankingCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rankingVM.todayRanking.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingCell, for: indexPath) as! RankingListViewCell
        
        let ranking = indexPath.row + 1
        cell.RankingTagLabel.text = "\(ranking)"
        cell.RankingListModel = rankingVM.todayRanking[indexPath.row]
        
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

extension RankingTableViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        rankingVM.loadTodayWorldRanking {
            self.tableView.reloadData()
        }
    }
}

