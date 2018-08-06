//
//  TodayChallengeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let kGameSmallCellID = "kGameSmallCellID"

class TodayChallengeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: 懒加载属性
    fileprivate lazy var todayChallengeVM : TodayChallengeViewModel = TodayChallengeViewModel()
    
    var listGames: NSArray!
    
    // MARK: 懒加载属性
    private lazy var todayFreeGameModels : [GameModel] = [GameModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //请求数据
        loadData()

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


// MARK:- 设置UI界面
extension TodayChallengeViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        
        //加载视图后执行任何附加设置。
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView.register(UINib(nibName: "GameLittleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kGameSmallCellID)
        //        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "kGameSmallCellID")
        
        //全局设置TableHeader
        //setupTableHeader()
        
    }
    private func setupNavigationBar() {
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    private func setupTableHeader() {
        //设置分区头尾的文字颜色：黑色
        //UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = UIColor.black
        //设置分区头尾的文字样式：14号粗体
        //UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).font = UIFont.boldSystemFont(ofSize: 14)
        //设置分区头尾的背景颜色：白色
        UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).backgroundColor = UIColor.white
    }
}

// MARK: -- delegate and datasource
extension TodayChallengeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return todayChallengeVM.games.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获Ccell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameSmallCellID, for: indexPath) as! GameLittleCollectionViewCell
        
        // 给Cell设置数据
        cell.GameLittleCellModel = todayChallengeVM.games[indexPath.item]

        /*
        let row = (indexPath as NSIndexPath).row
        let rowDict = self.listGames[row] as! NSDictionary
        
        cell.gameTitle.text = rowDict["gameTitle"] as? String
        cell.gameUnlockType.setTitle(rowDict["gameUnlockType"] as? String, for: .normal)
        //cell.levelTitle.text = rowDict["levelTitle"] as? String
        //cell.gameRanking.text = "\(rowDict["gameRanking"] as? Int ?? 0)"
        cell.peopleNum.text = "\(rowDict["peopleNum"] as? Int ?? 0)人参与"
        //cell.gameCover.backgroundColor = UIColorTemplates.colorFromString((rowDict["gameColorEnd"] as? String)!)
        
//        let backgroundImage = String(format: "%@", rowDict["gameBackground"] as! String)
//        cell.backgroundImage.image = UIImage(named: backgroundImage)
        
        let imagePath = String(format: "%@", rowDict["gameCoverURL"] as! String)
        cell.gameCover.image = UIImage(named: imagePath)
        */
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.collectionView!.deselectItem(at: indexPath, animated: true)
        print("进入游戏详情页")
        let itemDataModel = todayChallengeVM.games[indexPath.item]
        //设置图表属性
        Defaults[.chartViewDataColor] = itemDataModel.gameColor
        
        let gameID = itemDataModel.gameID
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
extension TodayChallengeViewController {
    fileprivate func loadData() {
        todayChallengeVM.loadAllGameData {
            //self.collectionView.reloadData()
        }
        
        //        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
        //            // 1.获取整体字典数据
        //            guard let resultDict = result as? [String : NSObject] else { return }
        //
        //            // 2.根据data的key获取数据
        //            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
        //
        //            // 3.字典转模型对象
        //            for dict in dataArray {
        //                self.todayFreeGameModels.append(TodayFreeGameModel(dict: dict))
        //            }
        //
        //            //刷新表格
        //            self.collectionView.reloadData()
        //        }
    }
}


