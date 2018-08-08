//
//  GameRankingViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/8.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class GameRankingViewModel {
    lazy var gameRanking : [GameRankingModel] = [GameRankingModel]()
        
    //定义属性
    //var gameID: Int?
    var gameID = Defaults[.rankingGameID]
    
}

extension GameRankingViewModel {
    //请求数据
    func loadGameRanking(finishedCallback : @escaping () -> ()) {
        //print("游戏ID：\(gameID ?? 0)----3")
        let rankingPlist = Bundle.main.path(forResource: "Game_\(gameID ?? 0)_Ranking", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let rankingArray = NSArray(contentsOfFile: rankingPlist!)! as? [[String : Any]] else {return}
        
         // 2.字典转模型
        for dict in rankingArray {
            self.gameRanking.append(GameRankingModel(dict: dict))
        }
        
        finishedCallback()
    }
    
}
