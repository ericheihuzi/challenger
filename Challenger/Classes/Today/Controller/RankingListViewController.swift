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
    fileprivate lazy var rankingVM : WorldRankingViewModel = WorldRankingViewModel()
    
    @IBOutlet var worldRankListTableView: UITableView!
    @IBOutlet var watchAll: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载数据
        loadRankingListData()
        
        watchAll.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
        worldRankListTableView.delegate = self
        worldRankListTableView.dataSource = self
        worldRankListTableView.register(UINib(nibName: "RankingListViewCell", bundle: nil), forCellReuseIdentifier: RankingCell)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension RankingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = rankingVM.rankingModel.count
        if count <= 6 {
            return count
        } else {
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Ccell
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingCell, for: indexPath) as! RankingListViewCell
        
        cell.RankingListModel = rankingVM.rankingModel[indexPath.row]
        
        return cell
    }
    
}

extension RankingListViewController {
    // MARK:- 网络数据请求
    func loadRankingListData() {
        rankingVM.loadRankingData {}
    }
}

