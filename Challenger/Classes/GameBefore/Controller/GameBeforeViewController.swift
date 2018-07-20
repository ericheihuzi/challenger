//
//  GameBeforeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/18.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts

class GameBeforeViewController: UIViewController {
    @IBOutlet var ContentView: UIView!
    @IBOutlet var ButtonBGView: UIView!
    @IBOutlet var dashedLineView: UIView!
    @IBOutlet var GameIntroduction: UIButton!
    @IBOutlet var dashedLineView2: UIView!
    @IBOutlet var dashedLineView3: UIView!
    
    //定义属性
    // 游戏ID
    var gameID : Int = 0
    /// 游戏封面图片对应的URLString
    var gameCover : String = ""
    /// 游戏背景图片对应的URLString
    var gameBackground : String = ""
    /// 游戏名称
    var gameTitle: String?
    /// 游戏等级
    var gameLevel : Int = 0
    /// 等级名称
    var levelTitle : String = ""
    /// 游戏主色(起始渐变色）
    var gameColorStart : String = ""
    /// 游戏主色(结束渐变色）
    var gameColorEnd : String = ""
    /// 参与人数
    var peopleNum : Int = 0
    /// 付费类型
    var gameUnlockType : String = ""
    /// 游戏排名
    var gameRanking : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
        print("gameTitle = \(String(describing: gameTitle))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 动态设置状态栏风格,透明导航栏
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    /*
    // MARK: - 监听屏幕旋转
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { context in
            //self.setBackground()
        }, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK:- 设置UI界面
extension GameBeforeViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        //设置背景
        setBackground()
        //设置内容UI
        setGameDetail()
    }
    private func setupNavigationBar() {
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        //设置标题
        self.navigationController?.navigationBar.topItem?.title = "名称是\(String(describing: gameTitle))"
    }
    private func setBackground() {
        
        //self.view.backgroundColor = Theme.MainColor
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named:"reasoning_bg")!)
        
        /*
        let backgroundImage = UIImage(named:"reasoning_bg")?.scaled(to: CGSize(width: kScreenW, height: kScreenH))
        let patternColor = UIColor.init(patternImage:backgroundImage!)
        self.view.backgroundColor = patternColor
        */
        
        let gradientContent = gradientBackground("#ff33dd00", "#ff339900")
        //gradientContent.frame.size = ContentView.frame.size
        gradientContent.frame.size = CGSize(width: kScreenH, height: kScreenH)
        ContentView.layer.insertSublayer(gradientContent, at: 0)
        
        let gradientView = gradientBackground("#00339900", "#ff339900")
        //gradientView.frame.size = ButtonBGView.frame.size
        gradientView.frame.size = CGSize(width: kScreenH, height: 64)
        ButtonBGView.layer.insertSublayer(gradientView, at: 0)
    }
    
    private func gradientBackground(_ startColor: String, _ endColor: String) -> CAGradientLayer {
        // 定义渐变的颜色（从黄色渐变到橙色）
        let Color1 = UIColorTemplates.colorFromString(startColor)
        let Color2 = UIColorTemplates.colorFromString(endColor)
        let gradientColors = [Color1.cgColor, Color2.cgColor]
        
        // 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        // 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        // 设置渲染的起始结束位置
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        //gradientLayer.frame = self.view.bounds
        return gradientLayer
    }
    private func setGameDetail() {
        //添加虚线
        dashedLine()
        //游戏介绍与玩法演示按钮样式
        GameIntroduction.layer.borderColor = UIColor.white.cgColor
        
    }
    //虚线样式
    private func dashedLine() {
        //顶部虚线
        dashedLineView.layer.addSublayer(drawDashLine(dashedLineView))
        dashedLineView.backgroundColor = UIColor.clear
        //能力维度标题右侧虚线
        dashedLineView2.layer.addSublayer(drawDashLine(dashedLineView2))
        dashedLineView2.backgroundColor = UIColor.clear
        //世界排名标题右侧虚线
        dashedLineView3.layer.addSublayer(drawDashLine(dashedLineView3))
        dashedLineView3.backgroundColor = UIColor.clear
    }
    //MARK:- 绘制虚线
    private func drawDashLine(_ lineView: UIView) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = lineView.bounds
        shapeLayer.position = CGPoint(x: lineView.frame.width / 2,
                                      y: lineView.frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        //shapeLayer.lineJoin = kCALineJoinRound
        //shapeLayer.lineDashPhase = 0
        shapeLayer.lineDashPattern = [4,4]
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 4.5))
        path.addLine(to: CGPoint(x: lineView.frame.width, y: 4.5))
        shapeLayer.path = path
        return shapeLayer
    }
    
}

