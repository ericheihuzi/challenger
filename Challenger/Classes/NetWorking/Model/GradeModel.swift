//
//  GradeModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/11/1.
//  Copyright © 2018 黑胡子. All rights reserved.
//

import UIKit

class GradeModel: NSObject {
    
    @objc var grade: String = ""
    @objc var describe: String = ""
    @objc var minscore: Int = 0
    @objc var maxscore: Int = 0
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}


