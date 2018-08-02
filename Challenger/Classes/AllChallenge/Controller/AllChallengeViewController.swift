//
//  AllChallengeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let GameBigCell = "Cell"

class AllChallengeViewController: UITableViewController {
    @IBOutlet var contentTableView: UITableView!
    
    // MARK: 懒加载属性
    fileprivate lazy var allChallengeVM : AllChallengeViewModel = AllChallengeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入全部挑战")
        
        //设置UI
        setupUI()
        
        //请求数据
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func unwindToAllChallengeViewController(_ sender: UIStoryboardSegue) { }
    
}

// MARK:- 设置UI界面
extension AllChallengeViewController {
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(UINib(nibName: "GameLargeTableViewCell", bundle: nil), forCellReuseIdentifier: GameBigCell)
    }
}

// MARK:- 遵守UITableView的协议
extension AllChallengeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allChallengeVM.games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: GameBigCell, for: indexPath) as! GameLargeTableViewCell
        
        cell.GameLargeCellModel = allChallengeVM.games[indexPath.row]
                
        /*
        let GameChallengeType = model.gameChallengeType
        if GameChallengeType == "reasoning" {
            cell.BackgroundImage.image = UIImage(named: "reasoning_bg")
        } else if GameChallengeType == "calculation" {
            cell.BackgroundImage.image = UIImage(named: "calculation_bg")
        } else if GameChallengeType == "inspection" {
            cell.BackgroundImage.image = UIImage(named: "inspection_bg")
        } else if GameChallengeType == "memory" {
            cell.BackgroundImage.image = UIImage(named: "memory_bg")
        } else if GameChallengeType == "space" {
            cell.BackgroundImage.image = UIImage(named: "space_bg")
        } else if GameChallengeType == "create" {
            cell.BackgroundImage.image = UIImage(named: "create_bg")
        } else {
            cell.BackgroundImage.image = UIImage(named: "reasoning_bg")
        }
        */
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        print("进入游戏详情页")
        let rowDataModel = allChallengeVM.games[indexPath.row]
        let gameID = rowDataModel.gameID
        
        print("--------------")
        self.performSegue(withIdentifier: "showGameBeforeSegue", sender: gameID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.GameID = sender as? Int
        }
    }
    
}

// MARK:- 网络数据请求
extension AllChallengeViewController {
    fileprivate func loadData() {
        allChallengeVM.loadAllGameData {
            //self.contentTableView.reloadData()
        }
        
    }
    
}

