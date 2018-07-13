//
//  CircleProgressView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/10.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class CircleProgressView: UIView {
    
    @IBOutlet var CircleProgressView: UIView!
    
    @IBOutlet var ProgressView: UIAnnularProgress!
    
    var progress:CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        progress = 0
        
        ProgressView = UIAnnularProgress(
            propressProperty:ProgressProperty(width: 5, progressEnd: 0.6, progressColor: Theme.BGColor_RedOrange),
            frame: CGRect(x: 15, y: 15, width: 60, height: 60)
        )
        self.addSubview(ProgressView!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        progress! = progress! + 0.25
        if progress! > 1.0 {
            progress! = 0
        }
        ProgressView?.setProgress(progress: progress!, time:0.6, animate: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initFromXIB()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXIB()
    }
    
    func initFromXIB() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CircleProgressView", bundle: bundle)
        CircleProgressView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.addSubview(CircleProgressView)
    }
}
