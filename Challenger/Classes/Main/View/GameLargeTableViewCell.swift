//
//  GameLargeTableViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/19.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameLargeTableViewCell: UITableViewCell {
    
    //控件属性
    @IBOutlet var CellView : UIView!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var gameCover: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameUnlockType: UIButton!
    @IBOutlet var peopleNum: UILabel!
    @IBOutlet var levelBGView: UIView!
    
    //定义模型属性
    var GameLargeCellModel : GameModel? {
        didSet {
            //设置基本信息
            gameTitle.text = GameLargeCellModel?.gameTitle
            
            //CellView.backgroundColor = UIColorTemplates.colorFromString((GameLargeCellModel?.gameColorEnd)!)
            
            gameUnlockType.setTitle(GameLargeCellModel?.gameUnlockType, for: .normal)
            peopleNum.text = "\(GameLargeCellModel?.peopleNum ?? 0)人参与"
            
            //设置图片
            let gameCoverURL = URL(string: GameLargeCellModel?.gameCover ?? "")
            gameCover.kf.setImage(with: gameCoverURL, placeholder: UIImage(named: "second"))
            
            let gameBackgroundURL = URL(string: GameLargeCellModel?.gameBackground ?? "")
            backgroundImage.kf.setImage(with: gameBackgroundURL, placeholder: UIImage(named: "reasoning_bg"))
        }
    }
    
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
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}
