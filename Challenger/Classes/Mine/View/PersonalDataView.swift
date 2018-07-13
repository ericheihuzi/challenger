//
//  PersonalDataView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class PersonalDataView: UIView {
    @IBOutlet var PersonalDataView: UIView!
    
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
        let nib = UINib(nibName: "PersonalDataView", bundle: bundle)
        PersonalDataView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        PersonalDataView.frame = bounds
        self.addSubview(PersonalDataView)
    }
}

//设置进度条UI
//extension PersonalDataView {
//    private func setupUI(CircleProgressView : UIAnnularProgress) {
//        CircleProgressView.progressProperty.width = 5
//        CircleProgressView.progressProperty.progressEnd = 0.1
//        CircleProgressView.progressProperty.progressColor = UIColor(red: 255/255, green: 92/255, blue: 51/255, alpha: 1)
//        CircleProgressView.frame = CGRect(x: 15, y: 15, width: 60, height: 60)
//    }
//}

