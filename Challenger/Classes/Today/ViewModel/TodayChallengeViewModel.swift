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
    func loadGameList(finishedCallback : @escaping () -> ()) {
        let plistPath = Bundle.main.path(forResource: "challengeGame", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            self.games.append(TodayChallengeModel(dict: dict))
        }
        
        // 3.完成回调array
        finishedCallback()
    }
    
    // 获取游戏列表
    // Method: .get
    func loadGameList2(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestGameList)") { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取游戏列表结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            print("获取游戏列表状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取游戏列表提示 = \(message)")
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            //print("获取游戏列表数据 = \(dataArray)")
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(TodayChallengeModel(dict: dict))
                print(dict)
            }
            
            for model in self.games {
                print(model.title)
            }
            
            
            //完成回调
            finishedCallback()
        }
    }
}
