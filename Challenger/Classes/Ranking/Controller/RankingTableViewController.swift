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
    fileprivate lazy var rankingVM : WorldRankingViewModel = WorldRankingViewModel()

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
        return rankingVM.rankingModel.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: RankingCell, for: indexPath) as! RankingListViewCell
        
        cell.RankingListModel = rankingVM.rankingModel[indexPath.row]

        return cell
    }

}

extension RankingTableViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        rankingVM.loadRankingData {}
    }
}

