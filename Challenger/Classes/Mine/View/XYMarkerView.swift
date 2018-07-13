//
//  RadarChartViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import Charts

public class XYMarkerView: BalloonMarker {
    public var xAxisValueFormatter: IAxisValueFormatter
    fileprivate var yFormatter = NumberFormatter()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets,
                xAxisValueFormatter: IAxisValueFormatter) {
        self.xAxisValueFormatter = xAxisValueFormatter
        yFormatter.minimumFractionDigits = 1
        yFormatter.maximumFractionDigits = 1
        super.init(color: color, font: font, textColor: textColor, insets: insets)
    }
    
    public override func refreshContent(entry: ChartDataEntry, highlight: Highlight) {
        let string = "x: "
            + xAxisValueFormatter.stringForValue(entry.x, axis: XAxis())
            + ", y: "
            + yFormatter.string(from: NSNumber(floatLiteral: entry.y))!
        setLabel(string)
    }
    
}
