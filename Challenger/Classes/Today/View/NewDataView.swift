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
    @IBOutlet var ChangeTimeLabel: UILabel!
    @IBOutlet var RankingLabel: UILabel!
    
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
        NewDataView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        NewDataView.frame = bounds
        self.addSubview(NewDataView)
        
    }
}

extension NewDataView {
    func loadNewData(_ challengeTime: Int, _ todayRanking: Int, _ rankingChange: Int) {
        let challengeTime: Int = challengeTime
        let todayRanking: Int = todayRanking
        let rankingChange: Int = rankingChange
        
        if rankingChange > 0 {
            self.RankingLabel.textColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
        } else if rankingChange < 0 {
            self.RankingLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0, blue: 0.07058823529, alpha: 1)
        } else {
            self.RankingLabel.textColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        }
        
        var rankingChangeText: String
        if rankingChange == 0 {
            rankingChangeText = ""
        } else {
            rankingChangeText = " (\(rankingChange))"
        }
        
        self.ChangeTimeLabel.text = "挑战次数：\(challengeTime)"
        self.RankingLabel.text = "今日排名：\(todayRanking)" + rankingChangeText
    }
}
