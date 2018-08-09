//
//  NewDataView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

@IBDesignable
class NewDataView: UIView {
    @IBOutlet var NewDataView: UIView!
    @IBOutlet var ChangeNumLabel: UILabel!
    @IBOutlet var RankingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadNewDataView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NewDataView", bundle: bundle)
        NewDataView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        NewDataView.frame = bounds
        self.addSubview(NewDataView)
    }

}

extension NewDataView {
    func loadNewDataView() {
        var challengeNum = "\(Defaults[.challengeNum])"
        var userWorldRanking = "\(Defaults[.userWorldRanking])"
        var rankingChange = "\(Defaults[.rankingChange])"
        
        if challengeNum == "0" {
            challengeNum = "挑战次数：- "
        } else {
            challengeNum = "挑战次数：\(challengeNum)"
        }
        self.ChangeNumLabel.text = challengeNum
        
        if userWorldRanking == "0" {
            userWorldRanking = "今日排名：- "
        } else {
            userWorldRanking = "今日排名：\(userWorldRanking)"
        }
        
        if rankingChange == "0" {
            rankingChange = ""
        } else {
            rankingChange = " (\(rankingChange))"
        }
        self.RankingLabel.text = userWorldRanking + rankingChange
        
        if Defaults[.challengeNum] > 0 {
            self.RankingLabel.textColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
        } else if Defaults[.challengeNum] < 0 {
            self.RankingLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0, blue: 0.07058823529, alpha: 1)
        } else {
            self.RankingLabel.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        }
    }
}
