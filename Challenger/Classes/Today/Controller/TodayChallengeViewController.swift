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
private let gameSmallCell = "gameSmallCell"

class TodayChallengeViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: 懒加载属性
    fileprivate lazy var todayGameVM : GameViewModel = GameViewModel()
    fileprivate lazy var userGameVM : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //请求数据
        loadData()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


// MARK:- 设置UI界面
extension TodayChallengeViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        
        //全局设置TableHeader
        //setupTableHeader()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView.register(UINib(nibName: "GameLittleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameSmallCell)
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
        return todayGameVM.gameList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameSmallCell, for: indexPath) as! GameLittleCollectionViewCell
        
        let itemDataModel = todayGameVM.gameList[indexPath.item]
        
        let gameID = itemDataModel.gameID
        
        todayGameVM.loadGameJoin(gameID) { join in
            cell.PeopleNum.text = "\(join)人参与"
        }
        
        // 给Cell设置数据
        cell.GameCover.backgroundColor = UIColorTemplates.colorFromString(itemDataModel.color)
        cell.GameLittleCellModel = itemDataModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView!.deselectItem(at: indexPath, animated: true)
        
        //登录判断
        guard Defaults[.isLogin] == true else {
            return PageJump.JumpToLogin(.present)
        }
        
        // 显示loading
        CBToast.showToastAction()
        
        // 获取游戏数据
        let gameData = todayGameVM.gameList[indexPath.item]
        
        let gameID = gameData.gameID
        let gameTitle = gameData.title
        let gameColor = gameData.color
        let category = gameData.category
        let level = gameData.level
        let coverName = gameData.coverName
        
        let GRES = gameData.rescore
        let GCAS = gameData.cascore
        let GINS = gameData.inscore
        let GMES = gameData.mescore
        let GSPS = gameData.spscore
        let GCRS = gameData.crscore
        let GS = [GRES,GCAS,GINS,GMES,GSPS,GCRS]
        
        // 请求用户数据
        self.userGameVM.loadUserGame(gameID) { dict2 in
            let userGameData = UserGameModel(dict: dict2)
            let userLevel = userGameData.level
            let ranking = userGameData.ranking
            let rankingChange = userGameData.rankingChange
            let nickName = Defaults[.nickName]
            
            let URES = userGameData.rescore
            let UCAS = userGameData.cascore
            let UINS = userGameData.inscore
            let UMES = userGameData.mescore
            let USPS = userGameData.spscore
            let UCRS = userGameData.crscore
            let US = [URES,UCAS,UINS,UMES,USPS,UCRS]
            
            let senderData:[String:Any] = [
                //游戏数据
                "gameID": gameID,
                "gameTitle": gameTitle,
                "gameColor": gameColor,
                "category": category,
                "level": level,
                "coverName": coverName,
                "chartGS": GS,
                "chartUS": US,
                "GRES": GRES,
                "GCAS": GCAS,
                "GINS": GINS,
                "GMES": GMES,
                "GSPS": GSPS,
                "GCRS": GCRS,
                
                //用户数据
                "userLevel": userLevel,
                "ranking": ranking,
                "rankingChange": rankingChange,
                "nickName": nickName ?? "",
                "URES": URES,
                "UCAS": UCAS,
                "UINS": UINS,
                "UMES": UMES,
                "USPS": USPS,
                "UCRS": UCRS
            ]
            
            // 隐藏loading
            CBToast.hiddenToastAction()
            
            self.performSegue(withIdentifier: "showGameBeforeSegue", sender: senderData)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.ReceiveData = sender as! [String : Any]
        }
    }
}

extension TodayChallengeViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        todayGameVM.loadGameList {
            // 加载列表数据
            self.collectionView.reloadData()
        }
    }
}


