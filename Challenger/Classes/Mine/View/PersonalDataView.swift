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
    
    // MARK: 懒加载属性
    fileprivate lazy var numVM : ChallengeInfoViewModel = ChallengeInfoViewModel()
    
    let userNickName = Defaults[.nickName]
    //var abilityRatio: Float? = 0.00
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //添加阴影
        self.PersonalDataView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.PersonalDataView.layer.shadowOpacity = 0.05
        self.PersonalDataView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        loadData()
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
        PersonalDataView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        PersonalDataView.frame = bounds
        self.addSubview(PersonalDataView)
    }
    
}

extension PersonalDataView {
    func loadCelebrate(_ abilityRatio: Float) {
        let Ratio = abs(Int(abilityRatio * 100))
        if abilityRatio <= 0.20 {
            self.UserCelebrateTitle.text = "加油！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(Ratio)%的挑战者，继续努力！"
        } else if abilityRatio > 0.20 && abilityRatio <= 0.50 {
            self.UserCelebrateTitle.text = "继续努力！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(Ratio)%的挑战者，继续努力！"
        } else if abilityRatio > 0.50 && abilityRatio <= 0.80 {
            self.UserCelebrateTitle.text = "太棒了！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(Ratio)%的挑战者，继续努力！"
        } else if abilityRatio > 0.80 && abilityRatio <= 1.00 {
            self.UserCelebrateTitle.text = "非常棒！" + userNickName!
            self.UserCelebrateDetail.text = "你超过了\(Ratio)%的挑战者，继续努力！"
        }
    }
    
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        numVM.loadWorldRanking{
            let models = self.numVM.worldRanking
            var num = 0
            for model in models {
                num += 1
                let userID = model.userID
                if userID == Defaults[.userID] {
                    print(num)
                    print(models.count)
                    let str = String(format: "%.2f", (Float(models.count) - Float(num)) / Float(models.count))
                    let ratio = Float(str) ?? 0.0
                    self.loadCelebrate(ratio)
                    print(ratio)
                }
            }
        }
    }
}

