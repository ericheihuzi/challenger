//
//  LocalGameViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/10/17.
//  Copyright © 2018 黑胡子. All rights reserved.
//

import Foundation
import UIKit

class LocalGameViewModel {
    func localGameLevel(_ userLevel: Int, _ gameID: String, finishedCallback : @escaping (_ dict: [String : Any]) -> ()) {
        let plistPath = Bundle.main.path(forResource: gameID + "_Level_Configure", ofType: "plist")
        
        // 1.获取属性列表文件中的全部数据
        guard let dataArray = NSArray(contentsOfFile: plistPath!)! as? [[String : Any]] else {return}
        
        // 2.字典转模型
        for dict in dataArray {
            let levelModel = LevelModel(dict: dict)
            let level = levelModel.level
            if level == userLevel {
                print(dict)
                
                // 3.完成回调
                finishedCallback(dict)
            }
        }
        
    }
}
