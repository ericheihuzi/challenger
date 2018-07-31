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
        print("进入全部挑战")
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
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        self.tableView.register(UINib(nibName: "GameLargeTableViewCell", bundle: nil), forCellReuseIdentifier: kGameBigCellID)
        //contentTableView?.register(UITableViewCell.self, forCellReuseIdentifier: kGameBigCellID)
        
    }
}

// MARK:- 遵守UITableView的协议
extension AllChallengeViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bigListGames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: kGameBigCellID, for: indexPath) as! GameLargeTableViewCell
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.bigListGames[row] as! NSDictionary
        
        //给Cell设置数据
        cell.gameTitle.text = rowDict["gameTitle"] as? String
        cell.gameUnlockType.setTitle(rowDict["gameUnlockType"] as? String, for: .normal)
        //cell.levelTitle.text = rowDict["levelTitle"] as? String
        //cell.gameRanking.text = "\(rowDict["gameRanking"] as? Int ?? 0)"
        cell.peopleNum.text = "\(rowDict["peopleNum"] as? Int ?? 0)人参与"
        
        let gameCoverURL = String(format: "%@", rowDict["gameCover"] as! String)
        cell.gameCover.image = UIImage(named: gameCoverURL)
        
        let gameBackgroundURL = String(format: "%@", rowDict["gameBackground"] as! String)
        cell.backgroundImage.image = UIImage(named: gameBackgroundURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView!.deselectRow(at: indexPath, animated: true)
        print("进入游戏详情页")
        let rowData = self.bigListGames[indexPath.row]
        self.performSegue(withIdentifier: "ShowDetailView", sender: rowData)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailView" {
            let controller = segue.destination as! GameBeforeViewController
            controller.GameData = sender as? NSDictionary
        }
    }
    
    private func gradientBackground(_ startColor: String, _ endColor: String, _ layerView: UIView) -> CAGradientLayer {
        // 定义渐变的颜色
        let Color1 = UIColorTemplates.colorFromString(startColor)
        let Color2 = UIColorTemplates.colorFromString(endColor)
        let gradientColors = [Color1.cgColor, Color2.cgColor]
        
        // 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        // 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        // 设置渲染的起始结束位置
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        //gradientLayer.frame = self.view.bounds
        gradientLayer.frame.size = CGSize(width: kScreenW-20, height: 140)
        return gradientLayer
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

