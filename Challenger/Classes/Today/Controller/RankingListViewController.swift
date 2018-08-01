//
//  RankingListViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let WorldRankingCell = "Cell"

class RankingListViewController: UIViewController {
    @IBOutlet var worldRankListTableView: UITableView!
    @IBOutlet var watchAll: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        watchAll.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
        worldRankListTableView.delegate = self
        worldRankListTableView.dataSource = self
        worldRankListTableView.register(UINib(nibName: "RankingListViewCell", bundle: nil), forCellReuseIdentifier: WorldRankingCell)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RankingListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Ccell
        let cell = tableView.dequeueReusableCell(withIdentifier: WorldRankingCell, for: indexPath) as! RankingListViewCell
        
        return cell
    }
    
}
