//
//  Tools.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/23.
//  Copyright © 2015年 koofrank. All rights reserved.
//

import UIKit
import SpriteKit

func randomInRange(_ range: ClosedRange<Int>) -> Int {
    let count = UInt32(range.upperBound - range.lowerBound)
    return  Int(arc4random_uniform(count)) + range.lowerBound
}

extension SKAction {
    class func moveDistance(_ distance:CGVector, fadeInWithDuration duration:TimeInterval) -> SKAction {
        let fadeIn = SKAction.fadeIn(withDuration: duration)
        let moveIn = SKAction.move(by: distance, duration: duration)
        return SKAction.group([fadeIn, moveIn])
    }
    
    class func moveDistance(_ distance:CGVector, fadeOutWithDuration duration:TimeInterval) -> SKAction {
        let fadeOut = SKAction.fadeOut(withDuration: duration)
        let moveOut = SKAction.move(by: distance, duration: duration)
        return SKAction.group([fadeOut, moveOut])
    }
}
