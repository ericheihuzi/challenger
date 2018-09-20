//
//  GameBeforeViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBeforeViewModel {
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
//        let accountPlist = Bundle.main.path(forResource: "UserAccount", ofType: "plist")
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
    
    // MARK:- 绘制虚线
    func drawDashLine(_ lineView: UIView) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = lineView.bounds
        shapeLayer.position = CGPoint(x: lineView.frame.width / 2,
                                      y: lineView.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        //shapeLayer.lineJoin = kCALineJoinRound
        //shapeLayer.lineDashPhase = 0
        shapeLayer.lineDashPattern = [2,3]
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 4.5))
        path.addLine(to: CGPoint(x: lineView.frame.width, y: 4.5))
        shapeLayer.path = path
        return shapeLayer
    }
    
    // MARK:- 绘制渐变背景
    func gradientBackground(_ startColor: String, _ endColor: String) -> CAGradientLayer {
        // 定义渐变的颜色（从黄色渐变到橙色）
        let Color1 = UIColorTemplates.colorFromString(startColor)
        let Color2 = UIColorTemplates.colorFromString(endColor)
        let gradientColors = [Color1.cgColor, Color2.cgColor]
        
        // 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        // 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        // 设置渲染的起始结束位置
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        //gradientLayer.frame = self.view.bounds
        return gradientLayer
    }
}
