//
//  AllChallengeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class AllChallengeViewModel {
    lazy var games : [AllChallengeModel] = [AllChallengeModel]()
}

extension AllChallengeViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        let plistPath = Bundle.main.path(forResource: "challengeGame", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            self.games.append(AllChallengeModel(dict: dict))
        }
        
        //验证方法
//        for model in self.games {
//            print(model.gameTitle)
//        }
        
        //print(dataArray)
        // 3.完成回调array
        finishedCallback()
    }
}

/*
extension AllChallengeViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(AllChallengeModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
*/
 
