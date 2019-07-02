//
//  GameLevelViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/1.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

private let LevelCell = "Cell"

class GameLevelViewController: UIViewController {
    @IBOutlet var levelNumLabel: UILabel!
    
    // MARK: - 懒加载属性
    fileprivate lazy var gameInfoVM : GameViewModel = GameViewModel()
    
    // 修改状态栏的样式为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var LevelCollectionView: UICollectionView!
    
    var LevelBackgroundImage: String?
    var gameLevel: Int = 0
    var userLevel: Int = 1
    var gameID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BackgroundImage.image = UIImage(named: LevelBackgroundImage!)
        
        levelNumLabel.text = "\(userLevel)" + "/" + "\(gameLevel)"
        
        self.LevelCollectionView.register(UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LevelCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startChallenge() {
        let GameID = self.gameID
        
        if Defaults[.isLogin] {
            if GameID == "IN-0001" {
                let gameSB = UIStoryboard(name: "StickHero", bundle:nil)
                let gameVC = gameSB.instantiateViewController(withIdentifier: "StickHeroViewController") as! StickHeroViewController
                gameVC.GameID = GameID
                
                // 请求游戏数据
                gameInfoVM.loadGameInfo(GameID) { dict in
                    let gameInfoData = GameInfoModel(dict: dict)
                    let userLevel = self.userLevel
                    gameVC.infoModel = gameInfoData
                    gameVC.userLevel = userLevel
                    self.present(gameVC, animated: true)
                }
            } else {
                CBToast.showToastAction(message: "敬请期待")
            }
        } else {
            CBToast.showToastAction(message: "您还没有登录")
        }
    }

}

// MARK: UICollectionViewDataSource
extension GameLevelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameLevel
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell, for: indexPath) as! LevelCollectionViewCell
        cell.layer.cornerRadius = 8
        
        let row = indexPath.row + 1
        cell.levelLabel.text = "\(row)"
        
        if row < userLevel {
            cell.levelState.image = UIImage(named: "icon_state_success")
        } else if row == userLevel {
            cell.levelState.image = UIImage(named: "icon_state_next")
        } else {
            cell.levelState.image = UIImage(named: "icon_state_fail")
            cell.levelState.alpha = 0.7
        }
        
        return cell
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let row = indexPath.row + 1
        print("__________----------------______--__-_-_-_-_--")
        if row == userLevel {
            print("__________----------------______--__-_-_-_-_--\(row)")
            startChallenge()
        }
    }
    */
    
}
