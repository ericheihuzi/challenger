//
//  GameViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/21.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class GameViewModel {
    lazy var games : [GameInfoModel] = [GameInfoModel]()
}

extension GameViewModel {
    // 获取用户指定游戏的信息
    // Method: .get
    // Parameters: token: String, gameID: String
    func loadUserGameInfo(_ gameID: String, finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestChallengeInfo)" + "token=" + Defaults[.token]! + "gameID=" + gameID) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("loadResult = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            print("获取用户指定游戏的信息状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取用户指定游戏的信息提示 = \(message)")
            
            if status == 0 {
                guard let challengeDict = resultDict["data"] as? [String : Any] else { return }
                print("获取用户指定游戏的信息 = \(challengeDict)")
               
            }
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 更新用户指定游戏信息
    // Method: .post
    // Parameters: gameID:String,ispay:Int,newscore:Int,maxscore:Int,level:Int
    // rescore/cascore/inscore/mescore/spscore/crscore:Int
    func updateUserGameInfo(_ userGameInfoUpdate : [String : Any], finishedCallback : @escaping (_ status : Int) -> ()) {
        print("要提交的信息 = \(userGameInfoUpdate)")
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: userGameInfoUpdate) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("updateResult = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            //print("updateStatus = \(status)")
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("updateMessage = \(message)")
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 获取游戏列表
    // Method: .get
    func loadGameList(finishedCallback : @escaping () -> ()) {
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
                self.games.append(GameInfoModel(dict: dict))
                print(dict)
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
}

