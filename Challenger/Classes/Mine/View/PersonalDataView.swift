//
//  PersonalDataView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

@IBDesignable
class PersonalDataView: UIView {
    @IBOutlet var PersonalDataView: UIView!
    @IBOutlet var UserCelebrateTitle: UILabel!
    @IBOutlet var UserCelebrateDetail: UILabel!
    
    let userNickName = Defaults[.nickName]
    //var abilityRatio: Float?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        loadCelebrate()
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
        let nib = UINib(nibName: "PersonalDataView", bundle: bundle)
        PersonalDataView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        PersonalDataView.frame = bounds
        self.addSubview(PersonalDataView)
    }
}

extension PersonalDataView {
    private func loadCelebrate() {
        let abilityRatio:Float = 0.90
        if abilityRatio <= 0.20 {
            self.UserCelebrateTitle.text = "加油！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(abilityRatio * 100)%的挑战者，继续努力！"
        } else if abilityRatio > 0.20 && abilityRatio <= 0.50 {
            self.UserCelebrateTitle.text = "继续努力！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(abilityRatio * 100)%的挑战者，继续努力！"
        } else if abilityRatio > 0.50 && abilityRatio <= 0.80 {
            self.UserCelebrateTitle.text = "太棒了！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(abilityRatio * 100)%的挑战者，继续努力！"
        } else if abilityRatio > 0.80 && abilityRatio <= 1.00 {
            self.UserCelebrateTitle.text = "非常棒！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(abilityRatio * 100)%的挑战者，继续努力！"
        }
    }
}

