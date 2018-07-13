//
//  UIAnnularProgress.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/9.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

struct ProgressProperty{
    var width: CGFloat
    var trackColor: UIColor
    var progressColor: UIColor
    var progressStart: CGFloat
    var progressEnd: CGFloat
    
    init(width:CGFloat,progressEnd:CGFloat,progressColor:UIColor) {
        self.width = width
        self.progressEnd = progressEnd
        self.progressColor = progressColor
        trackColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        progressStart = 0.0
    }
    
    init() {
        width = 10
        trackColor = UIColor.brown
        progressColor = UIColor.green
        progressStart = 0.0
        progressEnd = 0.0
    }
}

class UIAnnularProgress: UIView {
    
    var progressProperty = ProgressProperty.init()
    private let progressLayer = CAShapeLayer()
    
    init(propressProperty:ProgressProperty,frame:CGRect) {
        self.progressProperty = propressProperty
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        //逆时针旋转90度
        self.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi / (-2)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        //底部图形
        let path = UIBezierPath(ovalIn: bounds).cgPath
        let trackLayer = CAShapeLayer()
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = progressProperty.trackColor.cgColor
        trackLayer.lineWidth = progressProperty.width
        trackLayer.path = path
        layer.addSublayer(trackLayer)
        //进度图形
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressProperty.progressColor.cgColor
        progressLayer.lineWidth = progressProperty.width
        progressLayer.path = path
        progressLayer.strokeStart = progressProperty.progressStart
        progressLayer.strokeEnd = progressProperty.progressEnd
        layer.addSublayer(progressLayer)
    }
    //动画
    func setProgress(progress:CGFloat,time:CFTimeInterval,animate:Bool) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animate)
        CATransaction.setAnimationDuration(time)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        progressLayer.strokeEnd = progress
        CATransaction.commit()
    }
}
