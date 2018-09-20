//
//  GameBigTableViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBigTableViewCell: UITableViewCell {
    
    //控件属性
    @IBOutlet var gameCover: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameUnlockType: UIButton!
    @IBOutlet var levelTitle: UILabel!
    @IBOutlet var gameRanking: UILabel!
    @IBOutlet var levelBGView: UIView!
    
    //定义模型属性
//    var GameBigCellModel : GameInfoModel? {
//        didSet {
//            //设置基本信息
//            gameTitle.text = GameBigCellModel?.title
//            gameUnlockType.setTitle("\(GameBigCellModel?.price ?? 0)", for: .normal)
//            //levelTitle.text = GameBigCellModel?.levelTitle
//            //gameRanking.text = "\(GameBigCellModel?.gameRanking ?? 0)"
//
//            //设置图片
//            let headPath = "\(RequestHome)\(RequestGameCover)"
//            let coverName = GameBigCellModel?.coverName ?? ""
//            let gameCoverImage = URL(string: headPath + coverName)
//            gameCover.kf.setImage(with: gameCoverImage, placeholder: UIImage(named: "second"))
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameUnlockType.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        levelBGView.layer.cornerRadius = 8.0
        if #available(iOS 11.0, *) {
            levelBGView.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
}
