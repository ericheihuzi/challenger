//
//  AllChallengeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
private let kGameBigCellID = "kGameBigCellID"

class AllChallengeViewController: UITableViewController {
    
    var bigListGames: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        //请求数据
        loadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  Unwind action that is targeted by the demos which present a modal view
     *  controller, to return to the main screen.
     */
    @IBAction func unwindToAllChallengeViewController(_ sender: UIStoryboardSegue) { }
    
}

// MARK:- 设置UI界面
extension AllChallengeViewController {
    private func setupUI() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        //        self.contentTableView.delegate = self
        //        self.contentTableView.dataSource = self
        self.tableView.register(UINib(nibName: "GameBigTableViewCell", bundle: nil), forCellReuseIdentifier: kGameBigCellID)
        //contentTableView?.register(UITableViewCell.self, forCellReuseIdentifier: kGameBigCellID)
        
    }
}

// MARK: -- delegate and datasource
extension AllChallengeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bigListGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kGameBigCellID, for: indexPath) as! GameBigTableViewCell
        //cell.backgroundColor = UIColor.blue
        
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.bigListGames[row] as! NSDictionary
        //给Cell设置数据
        cell.gameTitle.text = rowDict["gameTitle"] as? String
        cell.gameUnlockType.setTitle(rowDict["gameUnlockType"] as? String, for: .normal)
        cell.levelTitle.text = rowDict["levelTitle"] as? String
        cell.gameRanking.text = "\(rowDict["gameRanking"] as? Int ?? 0)"
        cell.CellView.backgroundColor = UIColorTemplates.colorFromString((rowDict["gameColorEnd"] as? String)!)
        
        let imagePath = String(format: "%@", rowDict["gameCover"] as! String)
        cell.gameCover.image = UIImage(named: imagePath)
        
        return cell
    }
    
}

// MARK:- 网络数据请求
extension AllChallengeViewController {
    fileprivate func loadData() {
        
        let plistPath = Bundle.main.path(forResource: "challengeGame", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.bigListGames = NSArray(contentsOfFile: plistPath!)!
        
    }
    
}




