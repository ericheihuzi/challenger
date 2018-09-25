//
//  ProgressViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/28.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts

class ProgressViewController: UITableViewController, ChartViewDelegate {
   
    @IBOutlet var ContentTableView: UITableView!
    
    @IBOutlet var ReasoningChartView: LineChartView!
    @IBOutlet var CalculationChartView: LineChartView!
    @IBOutlet var InspectionChartView: LineChartView!
    @IBOutlet var MemoryChartView: LineChartView!
    @IBOutlet var SpaceChartView: LineChartView!
    @IBOutlet var CreateChartView: LineChartView!
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.setupUI(7)
            setupData()
            setupAnimate()
        case 1:
            self.setupUI(30)
            setupData()
            setupAnimate()
        case 2:
            self.setupUI(100)
            setupData()
            setupAnimate()
        default:
            break;
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //加载UI界面
        setupUI(7)
        //加载数据
        setupData()
        //动画持续时间
        //chartView.animate(yAxisDuration: 1.4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

//设置各项能力的数据界面
extension ProgressViewController {
    private func setupUI(_ axisMaxCount : Int) {
        //推理力界面
        SetChartUI(ReasoningChartView, axisMaxCount)
        //计算力界面
        SetChartUI(CalculationChartView, axisMaxCount)
        //视察力界面
        SetChartUI(InspectionChartView, axisMaxCount)
        //记忆力界面
        SetChartUI(MemoryChartView, axisMaxCount)
        //空间力界面
        SetChartUI(SpaceChartView, axisMaxCount)
        //创造力界面
        SetChartUI(CreateChartView, axisMaxCount)
    }
    
    private func SetChartUI(_ chartUI : LineChartView, _ axisMaxCount : Int) {
        chartUI.delegate = self
        chartUI.chartDescription?.enabled = false
        chartUI.dragEnabled = false
        chartUI.setScaleEnabled(false)
        chartUI.pinchZoomEnabled = false
        chartUI.legend.enabled = false
        
        let leftAxis = chartUI.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.axisMaximum = 300
        leftAxis.axisMinimum = 0
        leftAxis.drawLimitLinesBehindDataEnabled = true
        leftAxis.gridColor = Theme.BGColor_HighLightGray
        leftAxis.labelTextColor = Theme.TextColor_DarkGray
        
        let xAxis = chartUI.xAxis
        xAxis.labelTextColor = Theme.TextColor_DarkGray
        xAxis.gridColor = Theme.BGColor_HighLightGray
        xAxis.labelPosition = .bottom
        xAxis.axisMaximum = Double(axisMaxCount)
        xAxis.axisMinimum = 0
        
        chartUI.rightAxis.enabled = false
        
        let marker = BalloonMarker(color: UIColor(white: 0/255, alpha: 0.5),
                                   font: .systemFont(ofSize: 12),
                                   textColor: .white,
                                   insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8))
        marker.chartView = chartUI
        marker.minimumSize = CGSize(width: 40, height: 20)
        chartUI.marker = marker
        chartUI.legend.form = .line
    }
}

//设置各项能力的表格数据
extension ProgressViewController {
    private func setupData() {
        //推理力数据
        SetChartData(ReasoningChartView, "推理力", "#fff34dba", "#ffc643fb", 70, 300)
        //计算力数据
        SetChartData(CalculationChartView, "计算力", "#ff86fc6f", "#ff0cd318", 70, 300)
        //视察力数据
        SetChartData(InspectionChartView, "视察力", "#ffffc000", "#ffff7800", 70, 300)
        //记忆力数据
        SetChartData(MemoryChartView, "记忆力", "#ffc644fc", "#ff5856d6", 70, 300)
        //空间力数据
        SetChartData(SpaceChartView, "空间力", "#ff1ad5fd", "#ff1d64f0", 70, 300)
        //创造力数据
        SetChartData(CreateChartView, "创造力", "#ffff5e3a", "#ffff2a68", 70, 300)
    }
    
    private func SetChartData(_ chartName : LineChartView, _ label : String, _ startColor : String, _ endColor : String, _ count : Int, _ range : UInt32) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(range) + 3)
            return ChartDataEntry(x: Double(i), y: val, icon: #imageLiteral(resourceName: "icon"))
        }
        let set = LineChartDataSet(values: values, label: label)
        set.drawIconsEnabled = false
        // set.setColor(.init(red: 153/255, green: 153/255, blue: 255/255, alpha: 1))
        set.lineWidth = 0
        set.drawCirclesEnabled = false
        set.drawCircleHoleEnabled = false
        set.drawVerticalHighlightIndicatorEnabled = false
        set.drawHorizontalHighlightIndicatorEnabled = false
        set.drawValuesEnabled = false
        set.formSize = 10
        
        let gradientColors = [ChartColorTemplates.colorFromString(startColor).cgColor,
                              ChartColorTemplates.colorFromString(endColor).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        set.fillAlpha = 1
        set.fill = Fill(linearGradient: gradient, angle: 0)
        set.drawFilledEnabled = true
        
        let data = LineChartData(dataSet: set)
        chartName.data = data
    }
}

//设置进入动画
extension ProgressViewController {
    private func setupAnimate() {
        //推理力动画
        ReasoningChartView.animate(yAxisDuration: 1)
        //计算力动画
        CalculationChartView.animate(yAxisDuration: 1)
        //视察力动画
        InspectionChartView.animate(yAxisDuration: 1)
        //记忆力动画
        MemoryChartView.animate(yAxisDuration: 1)
        //空间力动画
        SpaceChartView.animate(yAxisDuration: 1)
        //创造力动画
        CreateChartView.animate(yAxisDuration: 1)
    }
}

