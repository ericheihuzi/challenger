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
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var GameCover: UIImageView!
    @IBOutlet var GameTitle: UILabel!
    @IBOutlet var GameUnlockType: UIButton!
    @IBOutlet var PeopleNum: UILabel!
    @IBOutlet var LevelBGView: UIView!
    
    var GameChallengeType: String?
    
    //定义模型属性
    var GameLargeCellModel : GameModel? {
        didSet {
            //设置基本信息
            self.GameTitle.text = GameLargeCellModel?.gameTitle
            
            //self.CellView.backgroundColor = UIColorTemplates.colorFromString((GameLargeCellModel?.gameColorEnd)!)
            
            self.GameUnlockType.setTitle(GameLargeCellModel?.gameUnlockType, for: .normal)
            self.PeopleNum.text = "\(GameLargeCellModel?.peopleNum ?? 0)人参与"
            
            self.GameChallengeType = GameLargeCellModel?.gameChallengeType
            self.BackgroundImage.image = UIImage(named: "\(GameLargeCellModel?.gameChallengeType ?? "reasoning")_bg")
            
            //设置图片
            let gameCoverURL = URL(string: GameLargeCellModel?.gameCoverURL ?? "")
            self.GameCover.kf.setImage(with: gameCoverURL, placeholder: UIImage(named: "second"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //judgeChallengeType()
        
        GameUnlockType.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        LevelBGView.layer.cornerRadius = 8.0
        self.GameCover.backgroundColor = Theme.MainColor
        if #available(iOS 11.0, *) {
            LevelBGView.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    /*
    func judgeChallengeType() {
        let GameChallengeType = GameLargeCellModel?.gameChallengeType
        if GameChallengeType == "reasoning" {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
        } else if GameChallengeType == "calculation" {
            self.BackgroundImage.image = UIImage(named: "calculation_bg")
        } else if GameChallengeType == "inspection" {
            self.BackgroundImage.image = UIImage(named: "inspection_bg")
        } else if GameChallengeType == "memory" {
            self.BackgroundImage.image = UIImage(named: "memory_bg")
        } else if GameChallengeType == "space" {
            self.BackgroundImage.image = UIImage(named: "space_bg")
        } else if GameChallengeType == "create" {
            self.BackgroundImage.image = UIImage(named: "create_bg")
        } else {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
        }
    }
    */
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}
