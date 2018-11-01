//
//  AllChallengeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

/*
import UIKit

class AllChallengeViewModel {
    lazy var games : [AllChallengeModel] = [AllChallengeModel]()
}

extension AllChallengeViewModel {
    func loadGameList(finishedCallback : @escaping (_ status: Int) -> ()) {
        let plistPath = Bundle.main.path(forResource: "challengeGame", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            self.games.append(AllChallengeModel(dict: dict))
            print(dict)
        }
        
        //验证方法
        for model in self.games {
            print(model.title)
        }
        let status = 0
        // 3.完成回调array
        finishedCallback(status)
    }
    
}
*/
