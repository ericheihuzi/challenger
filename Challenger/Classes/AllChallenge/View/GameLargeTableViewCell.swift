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
    @IBOutlet var ShadowView: UIView!
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
            judgeChallengeType((GameLargeCellModel?.gameChallengeType)!)
            //设置基本信息
            self.GameTitle.text = GameLargeCellModel?.gameTitle
            
            //self.CellView.backgroundColor = UIColorTemplates.colorFromString((GameLargeCellModel?.gameColor)!)
            
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
        }
        //添加阴影
        self.ShadowView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.ShadowView.layer.shadowOpacity = 0.5
    }
    
    func judgeChallengeType(_ challengeType: String) {
        let GameChallengeType = challengeType
        if GameChallengeType == "reasoning" {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.7764705882, green: 0.262745098, blue: 0.9843137255, alpha: 1)
        } else if GameChallengeType == "calculation" {
            self.BackgroundImage.image = UIImage(named: "calculation_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
        } else if GameChallengeType == "inspection" {
            self.BackgroundImage.image = UIImage(named: "inspection_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 1, green: 0.4705882353, blue: 0, alpha: 1)
        } else if GameChallengeType == "memory" {
            self.BackgroundImage.image = UIImage(named: "memory_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        } else if GameChallengeType == "space" {
            self.BackgroundImage.image = UIImage(named: "space_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.9411764706, alpha: 1)
        } else if GameChallengeType == "create" {
            self.BackgroundImage.image = UIImage(named: "create_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 1, green: 0.1647058824, blue: 0.4078431373, alpha: 1)
        } else {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.6, green: 0, blue: 1, alpha: 1)
        }
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        // Configure the view for the selected state
//    }
    
}
