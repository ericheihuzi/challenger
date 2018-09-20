//
//  TodayDataView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/3.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class TodayDataView: UIView {
    @IBOutlet var TodayDataView: UIView!
    
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
        let nib = UINib(nibName: "TodayDataView", bundle: bundle)
        TodayDataView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        TodayDataView.frame = bounds
        self.addSubview(TodayDataView)
        
    }

}
