//
//  UserDefaultsModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/9.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import SwiftyUserDefaults

class UserDefaultsModel {
    //定义属性：UserChallengeData
    var UserChallengeDefaultsModel : UserChallengeModel? {
        didSet {
            // 挑战次数
            Defaults[.challengeNum] = (UserChallengeDefaultsModel?.challengeNum)!
            // 排名变化
            Defaults[.rankingChange] = (UserChallengeDefaultsModel?.rankingChange)!
            // 世界排名
            Defaults[.userWorldRanking] = (UserChallengeDefaultsModel?.userWorldRanking)!
            // 综合分数
            Defaults[.userScore] = (UserChallengeDefaultsModel?.userScore)!
            // 段位
            Defaults[.userGrade] = UserChallengeDefaultsModel?.userGrade
        }
    }
}
