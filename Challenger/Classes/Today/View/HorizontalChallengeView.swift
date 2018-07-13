//
//  HorizontalChallengeView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class HorizontalChallengeView: UIView {
    
    @IBOutlet var HorizontalChallengeView: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    //系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
        let nib = UINib(nibName: "HorizontalChallengeView", bundle: bundle)
        HorizontalChallengeView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        HorizontalChallengeView.frame = bounds
        self.addSubview(HorizontalChallengeView)

    }
  
}
