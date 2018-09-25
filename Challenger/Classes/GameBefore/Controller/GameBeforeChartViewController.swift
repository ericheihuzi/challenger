//
//  GameBeforeChartViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/19.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts
import SwiftyUserDefaults

class GameBeforeChartViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet var chartView: RadarChartView!

    var GS = [Int]()
    var US = [Int]()
    var myDataColor = "#fff34dba"

    let activities = ["推理力", "计算力", "视察力", "记忆力", "空间力", "创造力"]
    var originalBarBgColor: UIColor!
    var originalBarTintColor: UIColor!
    var originalBarStyle: UIBarStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("图标主题颜色 = \(myDataColor)")
        print("游戏雷达数据 = \(GS)")
        print("用户雷达数据 = \(US)")
        
        setChartStyle()
        
    }
    
}

extension GameBeforeChartViewController {
    
    func setChartStyle() {
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.webLineWidth = 0
        chartView.innerWebLineWidth = 0
        // 雷达图内部线颜色
        chartView.webColor = Theme.BGColor_HighLightGray
        chartView.innerWebColor = Theme.BGColor_HighLightGray
        chartView.webAlpha = 1
        chartView.rotationEnabled = false
        chartView.rotationAngle = -120
        chartView.legend.enabled = false
        
        /*
         let marker = RadarMarkerView.viewFromXib()!
         marker.chartView = chartView
         chartView.marker = marker
         */
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 8, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        //脑力文字标题颜色
        xAxis.labelTextColor = Theme.MainColor
        //隐藏文字
        xAxis.drawLabelsEnabled = false
        
        let yAxis = chartView.yAxis
        yAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        yAxis.labelCount = 5
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 80
        yAxis.drawLabelsEnabled = false
        
        let l = chartView.legend
        l.horizontalAlignment = .center
        l.verticalAlignment = .center
        l.orientation = .horizontal
        l.drawInside = false
        l.font = .systemFont(ofSize: 12, weight: .light)
        l.xEntrySpace = 0
        l.yEntrySpace = 0
        l.textColor = .black
        
        setChartData()
        
        //动画持续时间
        chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setChartData() {
        //let mult: UInt32 = 80
        //let min: UInt32 = 20
        //设置数据个数
        //let cnt = 6
        
        //let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        //let entries1 = (0..<cnt).map(block)
        //let entries2 = (0..<cnt).map(block)
        
        var entries1: [RadarChartDataEntry] = []
        let gameData = GS
        for gi in gameData {
            let dataEntry = RadarChartDataEntry(value: Double(gi/3))
            entries1.append(dataEntry)
        }
        
        let set1 = RadarChartDataSet(values: entries1, label: "能力维度")
        set1.setColor(Theme.BGColor_LightGray)
        set1.fillColor = Theme.BGColor_LightGray
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.7
        set1.lineWidth = 1
        set1.drawHighlightCircleEnabled = false
        set1.setDrawHighlightIndicators(false)
        
        var entries2: [RadarChartDataEntry] = []
        let userData = US
        for ui in userData {
            let dataEntry = RadarChartDataEntry(value: Double(ui/3))
            entries2.append(dataEntry)
        }
        
        let set2 = RadarChartDataSet(values: entries2, label: "我的能力")
        set2.setColor(UIColorTemplates.colorFromString(myDataColor))
        set2.fillColor = UIColorTemplates.colorFromString(myDataColor)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 0.95
        set2.lineWidth = 1
        set2.drawHighlightCircleEnabled = false
        set2.setDrawHighlightIndicators(false)
        
        let data = RadarChartData(dataSets: [set1,set2])
        data.setValueFont(.systemFont(ofSize: 8))
        data.setDrawValues(false)
        data.setValueTextColor(.green)
        
        chartView.data = data
    }
    
}

extension GameBeforeChartViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

