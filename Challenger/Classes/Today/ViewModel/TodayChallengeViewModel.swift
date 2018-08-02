//
//  TodayChallengeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/3.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class TodayChallengeViewModel {
    lazy var games : [TodayChallengeModel] = [TodayChallengeModel]()
}

extension TodayChallengeViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        let plistPath = Bundle.main.path(forResource: "challengeGame", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            self.games.append(TodayChallengeModel(dict: dict))
        }
        
        finishedCallback()
    }
}
