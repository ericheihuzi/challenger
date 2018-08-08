//
//  WorldRankingViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/8.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class WorldRankingViewModel {
    lazy var rankingModel : [WorldRankingModel] = [WorldRankingModel]()
}

extension WorldRankingViewModel {
    func loadRankingData(finishedCallback : @escaping () -> ()) {
        let plistPath = Bundle.main.path(forResource: "WorldRanking", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            self.rankingModel.append(WorldRankingModel(dict: dict))
        }
        
        // 3.完成回调array
        finishedCallback()
    }
}
