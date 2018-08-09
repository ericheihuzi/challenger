//
//  UserChallengeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/9.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class UserChallengeViewModel {
    lazy var userChallenge : [UserChallengeModel] = [UserChallengeModel]()
}

extension UserChallengeViewModel {
    func loadUserChallenge(finishedCallback : @escaping () -> ()) {
        let challengePlist = Bundle.main.path(forResource: "UserChallengeData", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let challengeDict = NSDictionary(contentsOfFile: challengePlist!)! as? [String : Any] else {return}
        
        // 2.字典转模型
        self.userChallenge.append(UserChallengeModel(dict: challengeDict))

        // 3.完成回调array
        finishedCallback()
    }
}
