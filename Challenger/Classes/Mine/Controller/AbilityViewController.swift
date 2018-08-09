//
//  AbilityViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts
import SwiftyUserDefaults

class AbilityViewController: UITableViewController, ChartViewDelegate {
    
    @IBOutlet var contentTableView: UITableView!
    @IBOutlet var chartView: RadarChartView!
    @IBOutlet var shareButton: UIButton!
    
    @IBOutlet var ReasoningScoreLabel: UILabel!
    @IBOutlet var CalculationScoreLabel: UILabel!
    @IBOutlet var InspectionScoreLabel: UILabel!
    @IBOutlet var MemoryScoreLabel: UILabel!
    @IBOutlet var SpaceScoreLabel: UILabel!
    @IBOutlet var CreateScoreLabel: UILabel!
    
    var isLogin = Defaults[.isLogin]
    
    let activities = ["推理力", "计算力", "视察力", "记忆力", "空间力", "创造力"]
    var originalBarBgColor: UIColor!
    var originalBarTintColor: UIColor!
    var originalBarStyle: UIBarStyle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("显示能力啦")
        self.isLogin = Defaults[.isLogin]
        setScoreData()
    }
    
    // MARK: - 跳转
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGradeExplainSegue" {
            judgeIsLogin()
        }
    }
    
}

extension AbilityViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return activities[Int(value) % activities.count]
    }
}

extension AbilityViewController {
    //设置UI
    private func setupUI() {
        setChartUI()
        setShareButton()
    }
    
    //图标样式
    private func setChartUI() {
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
        //chartView.legend = l
        
        setChartData()
        
        //动画持续时间
        chartView.animate(xAxisDuration: 1, yAxisDuration: 1)
    }
    
    func setChartData() {
        let mult: UInt32 = 80
        let min: UInt32 = 20
        //设置数据个数
        let cnt = 6
        
        let block: (Int) -> RadarChartDataEntry = { _ in return RadarChartDataEntry(value: Double(arc4random_uniform(mult) + min))}
        let entries1 = (0..<cnt).map(block)
        //let entries2 = (0..<cnt).map(block)
        
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
    
    //分享按钮样式
    private func setShareButton() {
        shareButton.layer.borderColor = Theme.MainColor.cgColor
    }
    
    // MARK:- 若未登录，弹出登录界面
    private func judgeIsLogin() {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        
        if !isLogin {
            self.present(loginVC, animated: true)
        }
    }
    
    //加载雷达数据
    private func setScoreData() {
        ReasoningScoreLabel.text = "\(Defaults[.userReasoningScore])"
        CalculationScoreLabel.text = "\(Defaults[.userCalculationScore])"
        InspectionScoreLabel.text = "\(Defaults[.userInspectionScore])"
        MemoryScoreLabel.text = "\(Defaults[.userMemoryScore])"
        SpaceScoreLabel.text = "\(Defaults[.userSpaceScore])"
        CreateScoreLabel.text = "\(Defaults[.userCreateScore])"
    }
}

