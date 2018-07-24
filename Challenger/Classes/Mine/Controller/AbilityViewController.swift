//
//  AbilityViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts

class AbilityViewController: UITableViewController, ChartViewDelegate {
    
    @IBOutlet var contentTableView: UITableView!
    @IBOutlet var chartView: RadarChartView!
    @IBOutlet var shareButton: UIButton!
    
    let activities = ["推理力", "计算力", "视察力", "记忆力", "空间力", "创造力"]
    var originalBarBgColor: UIColor!
    var originalBarTintColor: UIColor!
    var originalBarStyle: UIBarStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupShareButton()
        
        //self.title = "Radar Bar Chart"
        /*
        self.options = [.toggleValues,
                        .toggleHighlight,
                        .toggleHighlightCircle,
                        .toggleXLabels,
                        .toggleYLabels,
                        .toggleRotate,
                        .toggleFilled,
                        .animateX,
                        .animateY,
                        .animateXY,
                        .spin,
                        .saveToGallery,
                        .toggleData]
        */
        chartView.delegate = self
        
        chartView.chartDescription?.enabled = false
        chartView.webLineWidth = 0
        chartView.innerWebLineWidth = 0
        // 雷达图内部线颜色
        chartView.webColor = Theme.BGColor_Purple
        chartView.innerWebColor = Theme.BGColor_HighLightGray
        chartView.webAlpha = 1
        chartView.rotationEnabled = false
        chartView.rotationAngle = -120
        chartView.legend.enabled = false
        
        let marker = RadarMarkerView.viewFromXib()!
        marker.chartView = chartView
        chartView.marker = marker
        
        let xAxis = chartView.xAxis
        xAxis.labelFont = .systemFont(ofSize: 12, weight: .light)
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        //脑力文字标题颜色
        xAxis.labelTextColor = UIColor.black
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
//        chartView.legend = l

        setChartData()
        
        //动画持续时间
        chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
/*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.15) {
            let navBar = self.navigationController!.navigationBar
            self.originalBarBgColor = navBar.barTintColor
            self.originalBarTintColor = navBar.tintColor
            self.originalBarStyle = navBar.barStyle

            //navBar.barTintColor = self.view.backgroundColor
            navBar.barTintColor = UIColor.white
            navBar.tintColor = .white
            navBar.barStyle = .default
        }
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.15) {
            let navBar = self.navigationController!.navigationBar
            navBar.barTintColor = self.originalBarBgColor
            navBar.tintColor = self.originalBarTintColor
            navBar.barStyle = self.originalBarStyle
        }
    }
    */
//    override func updateChartData() {
//        if self.shouldHideData {
//            chartView.data = nil
//            return
//        }
//
//        self.setChartData()
//    }
    
    func setChartData() {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        //设置数据个数
        let cnt = 6
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        //let entries2 = (0..<cnt).map(block)
        
        //let set1 = RadarChartDataSet(values: entries1, label: "平均脑力")
        let set1 = RadarChartDataSet(values: entries1, label: "我的脑力")
        set1.setColor(Theme.BGColor_DeepDarkPurple)
        set1.fillColor = UIColor(red: 88/255, green: 68/255, blue: 104/255, alpha: 1)
        set1.drawFilledEnabled = true
        set1.fillAlpha = 0.98
        set1.lineWidth = 2
        set1.drawHighlightCircleEnabled = false
        set1.setDrawHighlightIndicators(false)
        /*
        let set2 = RadarChartDataSet(values: entries2, label: "本周脑力")
        set2.setColor(UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1))
        set2.fillColor = UIColor(red: 121/255, green: 162/255, blue: 175/255, alpha: 1)
        set2.drawFilledEnabled = true
        set2.fillAlpha = 1
        set2.lineWidth = 0
        set2.drawHighlightCircleEnabled = true
        set2.setDrawHighlightIndicators(false)
        */
        //let data = RadarChartData(dataSets: [set1, set2])
        let data = RadarChartData(dataSets: [set1])
        data.setValueFont(.systemFont(ofSize: 10))
        data.setDrawValues(false)
        data.setValueTextColor(.white)
        
        chartView.data = data
    }
    /*
    override func optionTapped(_ option: Option) {
        switch option {
        case .toggleXLabels:
            chartView.xAxis.drawLabelsEnabled = !chartView.xAxis.drawLabelsEnabled
            chartView.data?.notifyDataChanged()
            chartView.notifyDataSetChanged()
            chartView.setNeedsDisplay()
            
        case .toggleYLabels:
            chartView.yAxis.drawLabelsEnabled = !chartView.yAxis.drawLabelsEnabled
            chartView.setNeedsDisplay()

        case .toggleRotate:
            chartView.rotationEnabled = !chartView.rotationEnabled
            
        case .toggleFilled:
            for set in chartView.data!.dataSets as! [RadarChartDataSet] {
                set.drawFilledEnabled = !set.drawFilledEnabled
            }
            
            chartView.setNeedsDisplay()
            
        case .toggleHighlightCircle:
            for set in chartView.data!.dataSets as! [RadarChartDataSet] {
                set.drawHighlightCircleEnabled = !set.drawHighlightCircleEnabled
            }
            chartView.setNeedsDisplay()

        case .animateX:
            chartView.animate(xAxisDuration: 1.4)
            
        case .animateY:
            chartView.animate(yAxisDuration: 1.4)
            
        case .animateXY:
            chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
            
        case .spin:
            chartView.spin(duration: 2, fromAngle: chartView.rotationAngle, toAngle: chartView.rotationAngle + 360, easingOption: .easeInCubic)
            
        default:
            super.handleOption(option, forChartView: chartView)
        }
    }
    */
}

extension AbilityViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

//设置按钮样式
extension AbilityViewController {
    //分享按钮样式
    private func setupShareButton() {
        shareButton.layer.borderColor = Theme.MainColor.cgColor
    }
}

