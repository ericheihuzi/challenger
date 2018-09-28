//
//  RankingListViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class RankingListViewCell: UITableViewCell {
    @IBOutlet var RankingTagLabel: UILabel!
    @IBOutlet var RankingChangeLabel: UILabel!
    @IBOutlet var HeadImageView: UIImageView!
    @IBOutlet var UserNickNameLabel: UILabel!
    @IBOutlet var UserMaxScoreLabel: UILabel!
    @IBOutlet var UpDownImageView: UIImageView!
    
    //定义模型属性
    var RankingListModel : ChallengeInfoModel? {
        didSet {
            //let change = abs(RankingListModel?.rankingChange ?? 0)
            //let updown = RankingListModel?.rankingChange ?? 0
            
            /*
            if updown > 0 {
                self.UpDownImageView.image = UIImage(named: "icon_up")
                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
            } else if updown < 0 {
                self.UpDownImageView.image = UIImage(named: "icon_down")
                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0, blue: 0.07058823529, alpha: 1)
            } else {
                self.UpDownImageView.image = UIImage(named: "icon_keep")
                self.RankingChangeLabel.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
            }
            */
            
            //设置基本信息
            //self.RankingTagLabel.text = "\(RankingListModel?.rankingTag ?? 0)"
            //self.RankingChangeLabel.text = "\(change)"
            self.UserNickNameLabel.text = RankingListModel?.nickName
            self.UserMaxScoreLabel.text = "\(RankingListModel?.score ?? 0)"
            
            // 设置头像
            //拼接头像路径
            let headPath = "\(RequestHome)\(RequestUserHeadImage)"
            let picName = RankingListModel?.picName ?? ""
            let headImageURL = URL(string: headPath + picName)
            
            let sex = RankingListModel?.sex
            if sex == 2 {
                self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
            } else {
                self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
            }
        }
    }
    
}
