//
//  RankingListViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let RankingCell = "Cell"

class RankingListViewController: UIViewController {
    
    // MARK: 懒加载属性
    fileprivate lazy var rankingVM : ChallengeInfoViewModel = ChallengeInfoViewModel()
    
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var worldRankListTableView: UITableView!
    @IBOutlet var watchAll: UIButton!
    @IBOutlet var rankingRefresh: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI
        setupUI()
        
        //加载数据
        loadRankingListData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.worldRankListTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 进入排行榜
    @IBAction func toRanking(_ sender: Any) {
        let rankingSB = UIStoryboard(name: "Ranking", bundle:nil)
        let rankingVC = rankingSB.instantiateViewController(withIdentifier: "RankingTableViewController") as! RankingTableViewController
        
        self.navigationController?.pushViewController(rankingVC, animated: true)
    }
    
    
    // 刷新今日排行榜
    @IBAction func rankingRefresh(_ sender: Any) {
        // 移除老数据
        self.rankingVM.todayRanking.removeAll()
        // 加载新数据
        self.loadRankingListData()
    }

}

extension RankingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = rankingVM.todayRanking.count
        if count <= 7 {
            return count
        } else {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Ccell
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingCell, for: indexPath) as! RankingListViewCell
        cell.RankingTagLabel.text = "\(indexPath.row + 1)"
        cell.RankingListModel = rankingVM.todayRanking[indexPath.row]
        
        return cell
    }
    
}

extension RankingListViewController {
    
    // MARK:- 设置UI
    func setupUI() {
        watchAll.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
        rankingRefresh.layer.borderColor = Theme.MainColor.cgColor
        
        worldRankListTableView.delegate = self
        worldRankListTableView.dataSource = self
        worldRankListTableView.register(UINib(nibName: "RankingListViewCell", bundle: nil), forCellReuseIdentifier: RankingCell)
    }
    
    // MARK:- 网络数据请求
    func loadRankingListData() {
        rankingVM.loadTodayWorldRanking {
            //self.setupHeight()
            self.worldRankListTableView.reloadData()
        }
    }
    
    /*
    func setupHeight() {
        //设置view高度
        let rowNum = rankingVM.todayRanking.count
        print("rowNum = \(rowNum)")
        worldRankListTableView.height = CGFloat(20 + rowNum * 50)
        worldRankListTableView.backgroundColor = UIColor.green
        contentView.backgroundColor = UIColor.yellow
        contentView.height = CGFloat(400)
    }
    */
}

