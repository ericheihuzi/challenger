//
//  GameSmallCollectionViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/11.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Kingfisher

class GameSmallCollectionViewCell: UICollectionViewCell {

    //控件属性
    @IBOutlet var gameCover: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameUnlockType: UIButton!
    @IBOutlet var levelTitle: UILabel!
    @IBOutlet var gameRanking: UILabel!
    
    //定义模型属性
//    var GameSmallCellModel : GameInfoModel? {
//        didSet {
//            //设置基本信息
//            gameTitle.text = GameSmallCellModel?.title
//            gameUnlockType.setTitle("\(GameSmallCellModel?.price ?? 0)", for: .normal)
//            //levelTitle.text = GameSmallCellModel?.levelTitle
//            //gameRanking.text = "\(GameSmallCellModel?.gameRanking ?? 0)"
//
//            //设置图片
//            let headPath = "\(RequestHome)\(RequestGameCover)"
//            let coverName = GameSmallCellModel?.coverName ?? ""
//            let gameCoverImage = URL(string: headPath + coverName)
//            gameCover.kf.setImage(with: gameCoverImage, placeholder: UIImage(named: "second"))
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.gameUnlockType.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //self.backgroundColor = UIColorTemplates.colorFromString("#ff000000")
    }

}
