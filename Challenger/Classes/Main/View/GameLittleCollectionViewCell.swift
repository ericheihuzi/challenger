//
//  GameLittleCollectionViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/19.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameLittleCollectionViewCell: UICollectionViewCell {
    
    //控件属性
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var gameCover: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameUnlockType: UIButton!
    @IBOutlet var peopleNum: UILabel!
    
    //定义模型属性
    var GameSmallCellModel : GameModel? {
        didSet {
            //设置基本信息
            gameTitle.text = GameSmallCellModel?.gameTitle
            gameUnlockType.setTitle(GameSmallCellModel?.gameUnlockType, for: .normal)
            peopleNum.text = "\(GameSmallCellModel?.peopleNum ?? 0)人参与"
            
            //设置图片
            let gameCoverURL = URL(string: GameSmallCellModel?.gameCover ?? "")
            gameCover.kf.setImage(with: gameCoverURL, placeholder: UIImage(named: "second"))
        }
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

}
