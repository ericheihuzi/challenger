//
//  ChallengeInfoViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/21.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class ChallengeInfoViewModel {
    lazy var challengeInfo : [ChallengeInfoModel] = [ChallengeInfoModel]()
    
    var challengeInfoLoad : ChallengeInfoModel? {
        didSet {
            Defaults[.score] = challengeInfoLoad?.score
            Defaults[.grade] = challengeInfoLoad?.grade
            Defaults[.challengeTime] = challengeInfoLoad?.challengeTime
            
            Defaults[.rewscore] = challengeInfoLoad?.rewscore
            Defaults[.cawscore] = challengeInfoLoad?.cawscore
            Defaults[.inwscore] = challengeInfoLoad?.inwscore
            Defaults[.mewscore] = challengeInfoLoad?.mewscore
            Defaults[.spwscore] = challengeInfoLoad?.spwscore
            Defaults[.crwscore] = challengeInfoLoad?.crwscore
        }
    }
    
}

extension ChallengeInfoViewModel {
    // 获取挑战信息
    // Method: .get
    // Parameters: token: String
    func loadChallengeInfo(finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestChallengeInfo)" + "?token=" + Defaults[.token]!) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取挑战信息结果 = \(resultDict)")
            
            // 获取status: 0-成功，1-用户信息为空，4-token已失效，请重新登录
            guard let status = resultDict["status"] as? Int else { return }
            print("获取挑战信息状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取挑战信息提示 = \(message)")
            
            if status == 0 {
                guard let challengeDict = resultDict["data"] as? [String : Any] else { return }
                print("获取挑战信息数据 = \(challengeDict)")
                
                // 将模型存入userDefaults
                let infoData = ChallengeInfoModel(dict: challengeDict)
                self.challengeInfoLoad = infoData
            }
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    
    // 更新挑战信息
    // Method: .post
    // Parameters: token:String,challengeTime:Int,score:int,grade:String
    // rewscore/cawscore/inwscore/mescore/spscore/crscore:Int
    func updateChallengeInfo(_ challengeInfoUpdate : [String : Any], finishedCallback : @escaping (_ status : Int) -> ()) {
        print("要提交的信息 = \(challengeInfoUpdate)")
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestChallengeInfoUpdate)", parameters: challengeInfoUpdate) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("更新挑战信息结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            //print("更新挑战信息状态 = \(status)")
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("更新挑战信息提示 = \(message)")
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    
}

