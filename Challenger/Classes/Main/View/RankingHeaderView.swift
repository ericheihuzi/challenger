//
//  RankingHeaderView.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/8.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

@IBDesignable
class RankingHeaderView: UIView {
    @IBOutlet var RankingHeaderView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        let nib = UINib(nibName: "RankingHeaderView", bundle: bundle)
        RankingHeaderView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        RankingHeaderView.frame = bounds
        self.addSubview(RankingHeaderView)
    }
}
