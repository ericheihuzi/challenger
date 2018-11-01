//
//  GameLevelViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/1.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

private let LevelCell = "Cell"

class GameLevelViewController: UIViewController {
    @IBOutlet var levelNumLabel: UILabel!
    
    // 修改状态栏的样式为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var LevelCollectionView: UICollectionView!
    
    var LevelBackgroundImage: String?
    var gameLevel: Int = 0
    var userLevel: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BackgroundImage.image = UIImage(named: LevelBackgroundImage!)
        
        levelNumLabel.text = "\(userLevel)" + "/" + "\(gameLevel)"
        
        self.LevelCollectionView.register(UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LevelCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        } else {
            cell.levelState.image = UIImage(named: "icon_state_fail")
            cell.levelState.alpha = 0.7
        }
        
        return cell
    }
}
