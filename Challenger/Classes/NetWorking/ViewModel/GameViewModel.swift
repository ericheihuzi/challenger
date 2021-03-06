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
    lazy var gameList : [GameInfoModel] = [GameInfoModel]()
    lazy var gameRanking : [ActorModel] = [ActorModel]()
    //lazy var gameInfo : [GameInfoModel] = [GameInfoModel]()
    //lazy var userGame : [UserGameModel] = [UserGameModel]()
}

extension GameViewModel {
    // 获取指定游戏信息
    // Method: .get
    // Parameters: gameID: String
    func loadGameInfo(_ gameID: String, finishedCallback : @escaping (_ dict: [String : Any]) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestGameInfo)" + "?gameID=" + gameID) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取指定游戏信息结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            print("获取指定游戏信息状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取指定游戏信息提示 = \(message)")
            
            if status == 0 {
                // 获取数据
                guard let dict = resultDict["data"] as? [String : Any] else { return }
                print("获取指定游戏信息数据 = \(dict)")
                
                //完成回调
                finishedCallback(dict)
                
                // 字典转模型
                //self.gameInfo.append(GameInfoModel(dict: dict))
            } else {
                print("获取游戏信息失败")
                CBToast.showToastAction(message: "获取游戏信息失败")
            }
            
        }
    }
    
    // 获取指定游戏排名列表
    // Method: .get
    // Parameters: gameID: String
    func loadGameRanking(_ gameID: String, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestGameRanking)" + "?gameID=" + gameID) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取游戏列表结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            print("获取游戏排名状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取游戏排名提示 = \(message)")
            
            if status == 0 {
                // 获取数据
                guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
                print("获取游戏排名数据 = \(dataArray)")
                
                // 字典转模型
                for dict in dataArray {
                    self.gameRanking.append(ActorModel(dict: dict))
                    //print(dict)
                }
            } else {
                print("获取游戏排名列表失败")
                //CBToast.showToastAction(message: "获取今日排名列表失败")
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
    
    // 获取指定游戏的参与人数
    // Method: .get
    // Parameters: gameID: String
    func loadGameJoin(_ gameID: String, finishedCallback : @escaping (_ join: Any) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestGameJoin)" + "?gameID=" + gameID) { (result) in
            guard let join = result as? Int else { return }
            //print("参与人数 = \(join)")
            finishedCallback(join)
        }
    }
    
    // 获取用户指定游戏的信息
    // Method: .get
    // Parameters: token: String, gameID: String
    func loadUserGame(_ gameID: String, finishedCallback : @escaping (_ dict: [String : Any]) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestUserGameInfo)" + "?token=" + Defaults[.token]! + "&gameID=" + gameID) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取用户游戏的信息结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            print("获取用户游戏的信息状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取用户游戏的信息提示 = \(message)")
            
            if status == 0 {
                // 获取数据
                guard let dict = resultDict["data"] as? [String : Any] else { return }
                print("获取用户游戏的信息 = \(dict)")
                
                //完成回调
                finishedCallback(dict)
                
                // 字典转模型
                //self.userGame.append(UserGameModel(dict: userGameDict))
            } else {
                finishedCallback(["":""])
                print("获取用户游戏信息失败")
                //CBToast.showToastAction(message: "获取用户游戏信息失败")
            }
            
            
        }
    }
    
    // 更新参与者信息
    // Method: .post
    // Parameters: gameID:String,ispay:Int,newscore:Int,maxscore:Int,level:Int
    // rescore/cascore/inscore/mescore/spscore/crscore:Int
    func updateActorInfo(_ actorInfoUpdate : [String : Any], finishedCallback : @escaping (_ status : Int) -> ()) {
        var actorInfoUpdate = actorInfoUpdate
        actorInfoUpdate["token"] = Defaults[.token]
        actorInfoUpdate["sex"] = Defaults[.sex]
        actorInfoUpdate["nickName"] = Defaults[.nickName]
        actorInfoUpdate["location"] = Defaults[.location]
        actorInfoUpdate["picName"] = Defaults[.picName]
        print("要提交的信息 = \(actorInfoUpdate)")
        
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestActorInfoUpdate)", parameters: actorInfoUpdate) { (result) in
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
            
            if status == 0 {
                // 获取数据
                guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
                //print("获取游戏列表数据 = \(dataArray)")
                
                // 字典转模型
                for dict in dataArray {
                    self.gameList.append(GameInfoModel(dict: dict))
                    print(dict)
                }
            } else {
                print("获取游戏列表失败")
                CBToast.showToastAction(message: "获取游戏列表失败")
            }
            
            //完成回调
            finishedCallback()
        }
    }
    
}

