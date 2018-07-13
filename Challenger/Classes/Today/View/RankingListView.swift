//
//  RankingListView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RankingListView: UIView {
    
    @IBOutlet var RankingListView: UIView!
    
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
        let nib = UINib(nibName: "RankingListView", bundle: bundle)
        RankingListView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        RankingListView.frame = bounds
        self.addSubview(RankingListView)
        
    }
    
}
