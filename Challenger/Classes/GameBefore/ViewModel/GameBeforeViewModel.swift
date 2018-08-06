//
//  GameBeforeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBeforeViewModel {
//    lazy var userAccount : [GBUserAccountModel] = [GBUserAccountModel]()
    lazy var gameData : [GBGameDataModel] = [GBGameDataModel]()
//    lazy var userGame: [GBUserGameModel] = [GBUserGameModel]()
    
    //lazy var gameBefore: [GameBeforeModel] = [GameBeforeModel]()
    
    //定义属性
    var gameID: Int?
    var gameTitle: String?
    var peopleNum: String?
    var gameCover: String?
    var gameChallengeType: String?
    

}

extension GameBeforeViewModel {
    //请求用户数据
//    func loadGBUserAccount(finishedCallback : @escaping () -> ()) {
//        let accountPlist = Bundle.main.path(forResource: "User", ofType: "plist")
//
//        // 1.获取属性列表文件中的全部数据
//        guard let accountDict = NSDictionary(contentsOfFile: accountPlist!)! as? [String : Any] else { return }
//        print(accountDict)
//        // 2.字典转模型
//        self.gameBefore.append(GameBeforeModel(dict: accountDict))
//
//        finishedCallback()
//    }
    
    
    //请求游戏数据
    func loadGBGameData(finishedCallback : @escaping () -> ()) {
        let gamePlist = Bundle.main.path(forResource: "Game_\(gameID ?? 0)_Configure", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let gameDataDic = NSDictionary(contentsOfFile: gamePlist!)! as? [String : Any] else {return}

        /*
        // 2.字典转模型
        self.gameData.append(GBGameDataModel(dict: gameDataDic))
        */
        
        //设置数据
        /// 游戏名称
        gameTitle = gameDataDic["gameTitle"] as? String
        ///参与人数
        peopleNum = "\(gameDataDic["peopleNum"] as? Int ?? 0)人参与"
        ///游戏封面图
        gameCover = gameDataDic["gameCover"] as? String
        ///挑战类型
        gameChallengeType = gameDataDic["gameChallengeType"] as? String
        
        finishedCallback()
    }
    
}

/*
extension GameBeforeViewModel {
    func loadAllGameData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            // 1.获取到数据
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            // 2.字典转模型
            for dict in dataArray {
                self.games.append(GameModel(dict: dict))
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
 */
