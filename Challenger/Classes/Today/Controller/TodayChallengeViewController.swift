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
//    fileprivate lazy var todayGameVM : TodayChallengeViewModel = TodayChallengeViewModel()
    var isLogin = Defaults[.isLogin]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
        
        //请求数据
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.isLogin = Defaults[.isLogin]
    }

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
        
        // 给Cell设置数据
        cell.GameLittleCellModel = todayGameVM.gameList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView!.deselectItem(at: indexPath, animated: true)
        
        //登录判断
        judgeIsLogin()
        
        //print("跳转到游戏详情页")
        let itemDataModel = todayGameVM.gameList[indexPath.item]
        //设置图表属性
        Defaults[.chartViewDataColor] = itemDataModel.color
        
        let gameID = itemDataModel.gameID
        print("gameID = \(gameID)")
        self.performSegue(withIdentifier: "showGameBeforeSegue", sender: gameID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGameBeforeSegue" {
            let controller = segue.destination as! GameBeforeViewController
            controller.GameID = sender as! String
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
    
    // MARK:- 若未登录，弹出登录界面
    fileprivate func judgeIsLogin() {
        if !isLogin {
            PageJump.JumpToLogin(.present)
        }
    }
}


