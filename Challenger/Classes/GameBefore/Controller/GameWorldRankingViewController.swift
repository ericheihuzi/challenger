//
//  GameWorldRankingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/23.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let WorldRankingGameCell = "WorldRankingGameCell"

class GameWorldRankingViewController: UIViewController {
    @IBOutlet var rankingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rankingTableView.delegate = self
        rankingTableView.dataSource = self
        rankingTableView.register(UINib(nibName: "WorldRankingTableViewCell", bundle: nil), forCellReuseIdentifier: WorldRankingGameCell)
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

extension GameWorldRankingViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获Ccell
        let cell = tableView.dequeueReusableCell(withIdentifier: WorldRankingGameCell, for: indexPath) as! WorldRankingTableViewCell
        
        return cell
    }
    
}
