//
//  NewDataView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class NewDataView: UIView {
    @IBOutlet var NewDataView: UIView!
    
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
        let nib = UINib(nibName: "NewDataView", bundle: bundle)
        NewDataView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        NewDataView.frame = bounds
        self.addSubview(NewDataView)
    }

}
