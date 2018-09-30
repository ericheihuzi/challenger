//
//  WorldRankingTableViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/23.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameRankingTableViewCell: UITableViewCell {
    @IBOutlet var RankingTagLabel: UILabel!
    @IBOutlet var RankingChangeLabel: UILabel!
    @IBOutlet var HeadImageView: UIImageView!
    @IBOutlet var NickNameLabel: UILabel!
    @IBOutlet var GameScoreLabel: UILabel!
    @IBOutlet var UpDownImageView: UIImageView!
    
    //定义模型属性
    var GameRankingListModel : ActorModel? {
        didSet {
//            let change = abs(GameRankingListModel?.rankingChange ?? 0)
//            let updown = GameRankingListModel?.rankingChange ?? 0
//
//            if updown > 0 {
//                self.UpDownImageView.image = UIImage(named: "icon_up")
//                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
//            } else if updown < 0 {
//                self.UpDownImageView.image = UIImage(named: "icon_down")
//                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0, blue: 0.07058823529, alpha: 1)
//            } else {
//                self.UpDownImageView.image = UIImage(named: "icon_keep")
//                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
//            }
            //设置基本信息
//            self.RankingTagLabel.text = "\(GameRankingListModel?.rankingTag ?? 0)"
//            self.RankingChangeLabel.text = "\(change)"
            self.NickNameLabel.text = GameRankingListModel?.nickName
            self.GameScoreLabel.text = "\(GameRankingListModel?.maxscore ?? 0)"
            
            // 设置头像
            //拼接头像路径
            let headPath = "\(RequestHome)\(RequestUserHeadImage)"
            let picName = GameRankingListModel?.picName ?? ""
            let headImageURL = URL(string: headPath + picName)
            
            let sex = GameRankingListModel?.sex
            if sex == 2 {
                self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
            } else {
                self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
            }
            
        }
    }
}
