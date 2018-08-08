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
    var RankingListModel : WorldRankingModel? {
        didSet {
            let change = abs(RankingListModel?.rankingChange ?? 0)
            let updown = RankingListModel?.rankingChange ?? 0
            
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
            
            //设置基本信息
            self.RankingTagLabel.text = "\(RankingListModel?.rankingTag ?? 0)"
            self.RankingChangeLabel.text = "\(change)"
            self.UserNickNameLabel.text = RankingListModel?.userNickName
            self.UserMaxScoreLabel.text = "\(RankingListModel?.userMaxScore ?? 0)"
            
            //设置头像
            let userHeadImageURL = URL(string: RankingListModel?.headImageURL ?? "")
            self.HeadImageView.kf.setImage(with: userHeadImageURL, placeholder: UIImage(named: "icon"))
        }
    }

    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
}
