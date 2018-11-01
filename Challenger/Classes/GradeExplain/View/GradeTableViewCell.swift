//
//  GradeTableViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/11/1.
//  Copyright © 2018 黑胡子. All rights reserved.
//

import UIKit

class GradeTableViewCell: UITableViewCell {
    @IBOutlet var BgView: UIView!
    @IBOutlet var GradeLabel: UILabel!
    @IBOutlet var ScoreLabel: UILabel!
    @IBOutlet var DescribeLabel: UILabel!
    @IBOutlet var MyGradeView: UIView!
    
    //定义模型属性
    var GradeCellModel : GradeModel? {
        didSet {
            self.DescribeLabel.text = GradeCellModel?.describe
            let minscore = GradeCellModel?.minscore ?? 0
            let maxscore = GradeCellModel?.maxscore ?? 0
            self.ScoreLabel.text = "脑力值范围:" + "\(minscore)" + "~" + "\(maxscore)"
            self.GradeLabel.text = GradeCellModel?.grade
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //添加阴影
        self.BgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.BgView.layer.shadowOpacity = 0.05
        self.BgView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    /*
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    */
}
