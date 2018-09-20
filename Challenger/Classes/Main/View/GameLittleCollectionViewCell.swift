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
    @IBOutlet var ShadowView: UIView!
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var GameCover: UIImageView!
    @IBOutlet var GameTitle: UILabel!
    @IBOutlet var GameUnlockType: UIButton!
    @IBOutlet var PeopleNum: UILabel!
    
    //定义模型属性
    var GameLittleCellModel : GameInfoModel? {
        didSet {
            judgeCategory((GameLittleCellModel?.category)!)
            //设置基本信息
            GameTitle.text = GameLittleCellModel?.title
            
            if GameLittleCellModel?.price == 0 {
                GameUnlockType.setTitle("免费", for: .normal)
            } else {
                GameUnlockType.setTitle("\(GameLittleCellModel?.price ?? 0)", for: .normal)
            }
            
            PeopleNum.text = "\(GameLittleCellModel?.join ?? 0)人参与"
            
            //设置图片
            let headPath = "\(RequestHome)\(RequestGameCover)"
            let coverName = GameLittleCellModel?.coverName ?? ""
            let gameCover = URL(string: headPath + coverName)
            GameCover.kf.setImage(with: gameCover, placeholder: UIImage(named: "second"))
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        GameUnlockType.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        BackgroundImage.backgroundColor = Theme.MainColor
        //添加阴影
        self.ShadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.ShadowView.layer.shadowOpacity = 0.5
    }
    
    func judgeCategory(_ category: String) {
        //let GameChallengeType = category
        if category == "reasoning" {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.7764705882, green: 0.262745098, blue: 0.9843137255, alpha: 1)
        } else if category == "calculation" {
            self.BackgroundImage.image = UIImage(named: "calculation_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
        } else if category == "inspection" {
            self.BackgroundImage.image = UIImage(named: "inspection_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 1, green: 0.4705882353, blue: 0, alpha: 1)
        } else if category == "memory" {
            self.BackgroundImage.image = UIImage(named: "memory_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
        } else if category == "space" {
            self.BackgroundImage.image = UIImage(named: "space_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.9411764706, alpha: 1)
        } else if category == "create" {
            self.BackgroundImage.image = UIImage(named: "create_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 1, green: 0.1647058824, blue: 0.4078431373, alpha: 1)
        } else {
            self.BackgroundImage.image = UIImage(named: "reasoning_bg")
            self.ShadowView.layer.shadowColor = #colorLiteral(red: 0.6, green: 0, blue: 1, alpha: 1)
        }
    }

}
