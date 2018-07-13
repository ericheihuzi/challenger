//
//  RadarChartViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//
//  https://github.com/danielgindi/Charts
//

import Foundation
import Charts

public class RadarMarkerView: MarkerView {
    @IBOutlet var label: UILabel!
    
    public override func awakeFromNib() {
        self.offset.x = -self.frame.size.width / 2.0
        self.offset.y = -self.frame.size.height - 7.0
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        label.text = String.init(format: "%d %%", Int(round(entry.y)))
        layoutIfNeeded()
    }
}
