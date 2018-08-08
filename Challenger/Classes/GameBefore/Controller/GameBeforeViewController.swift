//
//  GameBeforeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/18.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Charts
import SwiftyUserDefaults

class GameBeforeViewController: UIViewController {
    
    // MARK: - 懒加载属性
    fileprivate lazy var gameBeforeVM : GameBeforeViewModel = GameBeforeViewModel()
    
    // MARK: - 控件属性
    @IBOutlet var ContentView: UIView!
    @IBOutlet var ButtonBGView: UIView!
    @IBOutlet var dashedLineView: UIView!
    @IBOutlet var gameIntroduction: UIButton!
    @IBOutlet var dashedLineView2: UIView!
    @IBOutlet var dashedLineView3: UIView!
    @IBOutlet var PeopleNum: UILabel!
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var GameTitle: UILabel!
    @IBOutlet var watchALL: UIButton!
    @IBOutlet var GameCover: UIImageView!
    @IBOutlet var StartGameButton: UIButton!
    @IBOutlet var TiaozhanView: UIView!
    @IBOutlet var UserHeadImageView: UIImageView!
    
    //雷达数据label
    @IBOutlet var ReasoningLabel: UILabel! //推理力
    @IBOutlet var CalculationLabel: UILabel! //计算力
    @IBOutlet var InspectionLabel: UILabel! //视察力
    @IBOutlet var MemoryLabel: UILabel! //记忆力
    @IBOutlet var SpaceLabel: UILabel! //空间力
    @IBOutlet var CreateLabel: UILabel! //创造力
    
    //用户游戏数据
    @IBOutlet var MaxScoreLabel: UILabel! //用户最高分
    @IBOutlet var LevelLabel: UILabel! //挑战等级：用户/游戏
    @IBOutlet var UserRankingLabel: UILabel! //显示用户排名
    var UserGameLevel: String = "" //用户挑战等级
    var UserGameRanking: String = "" //用户排名
    var UserRankingChange: Int = 0 //用户排名变化
    var UserRankingText: String = "" //用户描述
    var IsUnlock: Int = 0 //是否解锁
    var UserRadarScore: Dictionary = [
        "reasoningRS" : 0,
        "calculationRS" : 0,
        "inspectionRS" : 0,
        "memoryRS" : 0,
        "spaceRS" : 0,
        "createRS" : 0
    ]
    
    //用户账户数据
    var UserNickName: String = "" //用户昵称
    
    //游戏数据
    var GameLevel: String = "" // 游戏挑战等级
    var GameChallengeType: String = "" //游戏挑战类型
    var GameID : Int? //游戏ID
    var GameRadarScore: Dictionary = [
        "reasoningRS" : 0,
        "calculationRS" : 0,
        "inspectionRS" : 0,
        "memoryRS" : 0,
        "spaceRS" : 0,
        "createRS" : 0
    ]
    
    var isLogin = Defaults[.isLogin] //登录状态
    
    // 雷达图属性
    //var ChartViewDataColor: String?
    // 挑战等级页面属性
    var LevelColorStart: String?
    var LevelColorEnd: String?
    var LevelBackground: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入游戏详情页")
        // 请求数据
        //requestData()
        // 加载数据
        loadData()
        //设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 动态设置状态栏风格,透明导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.isLogin = Defaults[.isLogin]
        loadUserGameData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    @IBAction func unwindToGameBeforeViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startChallenge(_ sender: UIButton) {
        if isLogin {
            CBToast.showToastAction(message: "敬请期待")
        } else {
            CBToast.showToastAction(message: "您还没有登录")
        }
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
        // 判断挑战类型,并设置UI风格
        judgeChallengeType()
        // 设置导航栏
        setupNavigationBar()
        // 设置内容UI
        setGameDetail()
    }
    private func setupNavigationBar() {
        // 设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        // 设置标题
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.navigationController?.navigationBar.topItem?.title = "\(String(describing: gameTitle))"
    }
    
    // MARK: - 传值Container View的UI属性
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChartViewSegue" {
            //let chartVC = segue.destination as! GameBeforeChartViewController
            //judgeChallengeType()
            //chartVC.myDataColor = ChartViewDataColor!
        } else if segue.identifier == "RankingViewSegue" {
            let rankingVC = segue.destination as! GameWorldRankingViewController
            //print("游戏ID：\(GameID!)----1")
            rankingVC.GameID = GameID
        } else if segue.identifier == "showGameLevelSegue" {
            let levelVC = segue.destination as! GameLevelViewController
            judgeChallengeType()
            levelVC.LevelCellColor = LevelColorEnd!
            levelVC.levelBackgroundColor = LevelColorStart!
            levelVC.LevelBackgroundImage = LevelBackground!
        } else if segue.identifier == "showGameRankingSegue" {
            //print("游戏ID：\(GameID!)----5")
            //let tableVC = segue.destination as! GameRankingTableViewController
            //tableVC.GameID = GameID
            
            //设置游戏排名的游戏ID
            Defaults[.rankingGameID] = GameID!
            //print("游戏ID：\(Defaults[.rankingGameID] ?? 0)----7")
        }
    }
    
    private func judgeChallengeType() {
        let challengeType = self.GameChallengeType
        if challengeType == "reasoning" {
            setGameStyle("#fff34dba", "#ffc643fb", "#00c643fb", "reasoning_bg")
        } else if challengeType == "calculation" {
            setGameStyle("#ff86fc6f", "#ff0cd318", "#000cd318", "calculation_bg")
        } else if challengeType == "inspection" {
            setGameStyle("#ffffc000", "#ffff7800", "#00ff7800", "inspection_bg")
        } else if challengeType == "memory" {
            setGameStyle("#ffc644fc", "#ff5856d6", "#005856d6", "memory_bg")
        } else if challengeType == "space" {
            setGameStyle("#ff1ad5fd", "#ff1d64f0", "#001d64f0", "space_bg")
        } else if challengeType == "create" {
            setGameStyle("#ffff5e3a", "#ffff2a68", "#00ff2a68", "create_bg")
        } else {
            setGameStyle("#fff34dba", "#ffc643fb", "#00c643fb", "reasoning_bg")
            //setGameStyle("#ff000000", "#ff000000", "#00000000", "second")
        }
    }
    
    private func setGameStyle(_ colorStart: String, _ colorEnd: String, _ colorAlpha: String, _ backgroundImage: String) {
        
        //print("\(colorStart) \(colorEnd) \(colorAlpha) \(backgroundImage)")
        
        // MARK: - 加载数据：背景色
        self.view.backgroundColor = UIColorTemplates.colorFromString(colorEnd)
        BackgroundImage.image = UIImage(named: backgroundImage)
        
        /*
        let gradientContent = gradientBackground("#ff33dd00", "#ff339900")
        //gradientContent.frame.size = ContentView.frame.size
        gradientContent.frame.size = CGSize(width: kScreenH, height: kScreenH)
        ContentView.layer.insertSublayer(gradientContent, at: 0)
         */

        // MARK: - 加载数据：开始游戏按钮的背景渐变色
        let gradientView = gradientBackground(colorAlpha, colorEnd)
        //gradientView.frame.size = ButtonBGView.frame.size
        gradientView.frame.size = CGSize(width: kScreenH, height: 64)
        ButtonBGView.layer.insertSublayer(gradientView, at: 0)
        
        // MARK: - 加载数据：开始按钮样式
        StartGameButton.layer.shadowColor = UIColorTemplates.colorFromString(colorEnd).cgColor
        StartGameButton.setTitleColor(UIColorTemplates.colorFromString(colorEnd), for: .normal)
        
        // MARK: - 设置维度图表(GameBeforeChartViewController)的主题颜色
        //self.ChartViewDataColor = colorStart
        // MARK: - 设置游戏等级界面(GameLevelViewController)的背景图
        self.LevelColorStart = colorStart
        self.LevelColorEnd = colorEnd
        self.LevelBackground = backgroundImage
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
        // 添加虚线
        dashedLine()
        // 游戏介绍与玩法演示按钮样式
        gameIntroduction.layer.borderColor = UIColor.white.cgColor
        // 开始游戏按钮样式
        StartGameButton.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        StartGameButton.layer.shadowOpacity = 0.8
        // 查看全部按钮样式
        watchALL.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
        // 设置挑战等级
        self.LevelLabel.text = UserGameLevel + "/" + GameLevel
        // 设置雷达数据
        self.ReasoningLabel.text = "\(UserRadarScore["reasoningRS"] ?? 0)" + "/" + "\(GameRadarScore["reasoningRS"] ?? 0)"
        self.CalculationLabel.text = "\(UserRadarScore["calculationRS"] ?? 0)" + "/" + "\(GameRadarScore["calculationRS"] ?? 0)"
        self.InspectionLabel.text = "\(UserRadarScore["inspectionRS"] ?? 0)" + "/" + "\(GameRadarScore["inspectionRS"] ?? 0)"
        self.MemoryLabel.text = "\(UserRadarScore["memoryRS"] ?? 0)" + "/" + "\(GameRadarScore["memoryRS"] ?? 0)"
        self.SpaceLabel.text = "\(UserRadarScore["spaceRS"] ?? 0)" + "/" + "\(GameRadarScore["spaceRS"] ?? 0)"
        self.CreateLabel.text = "\(UserRadarScore["createRS"] ?? 0)" + "/" + "\(GameRadarScore["createRS"] ?? 0)"
        // 设置用户标语
        judgeUserRankingText()
        let textColor = UIColorTemplates.colorFromString(Defaults[.chartViewDataColor] ?? "#ff000000")
        self.UserRankingLabel.textColor = textColor
        self.UserRankingLabel.text = UserRankingText + UserGameRanking + "，继续加油哦！"
    }
    
    //根据排名变化判断描述
    private func judgeUserRankingText() {
        if UserRankingChange < 0 {
            let change1 = abs(UserRankingChange)
            self.UserRankingText = "很遗憾~ " + UserNickName + "，你的排名下降了\(change1)个名次，现在的排名是"
        } else if UserRankingChange > 0 {
            let change2 = abs(UserRankingChange)
            self.UserRankingText = "太棒了！" + UserNickName + "，你的排名上升了\(change2)个名次，现在的排名是"
        } else {
            self.UserRankingText = "太棒了！" + UserNickName + "，当前排名"
        }
    }
    
    //虚线样式
    private func dashedLine() {
        // 顶部虚线
        dashedLineView.layer.addSublayer(drawDashLine(dashedLineView))
        dashedLineView.backgroundColor = UIColor.clear
        // 能力维度标题右侧虚线
        dashedLineView2.layer.addSublayer(drawDashLine(dashedLineView2))
        dashedLineView2.backgroundColor = UIColor.clear
        // 世界排名标题右侧虚线
        dashedLineView3.layer.addSublayer(drawDashLine(dashedLineView3))
        dashedLineView3.backgroundColor = UIColor.clear
    }
    
    // MARK:- 绘制虚线
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
        shapeLayer.lineDashPattern = [2,3]
        let path:CGMutablePath = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 4.5))
        path.addLine(to: CGPoint(x: lineView.frame.width, y: 4.5))
        shapeLayer.path = path
        return shapeLayer
    }
}

// MARK:- 配置数据
extension GameBeforeViewController {
    // 请求数据
    private func requestData() {
        
        // MARK: - 请求用户数据：用户ID、解锁状态、最新分数、最高分数、当前等级、维度值、排名
        //gameBeforeVM.loadGBUserAccount {}
        
        // MARK: - 请求游戏数据：游戏名称、参与人数、游戏等级数、游戏维度值
        //gameBeforeVM.loadGBGameData() {}
    }
    
    // 加载数据
    private func loadData() {
        loadGameInfoData()
        loadUserGameData()
        //loadUserInfoData()
    }
    
    // MARK: - 请求游戏属性数据
    private func loadGameInfoData() {
        guard let gamePlist = Bundle.main.path(forResource: "Game_\(GameID!)_Configure", ofType: "plist") else {return}
        // 获取属性列表文件中的全部数据
        guard let gameDataDict = NSDictionary(contentsOfFile: gamePlist)! as? [String : Any] else {return}

        /// 游戏名称
        self.GameTitle.text = gameDataDict["gameTitle"] as? String
        ///参与人数
        self.PeopleNum.text = "\(gameDataDict["peopleNum"] as? Int ?? 0)人参与"
        ///游戏封面图
        let gameCoverURL = URL(string: gameDataDict["gameCoverURL"] as! String)
        self.GameCover.kf.setImage(with: gameCoverURL, placeholder: UIImage(named: "second"))
        ///挑战类型
        self.GameChallengeType = gameDataDict["gameChallengeType"] as! String
        ///游戏等级数量
        self.GameLevel = "\(gameDataDict["gameLevelCount"] as! Int)"
        ///维度图标主色
        //self.ChartViewDataColor = gameDataDict["gameColor"] as? String
        ///雷达数据
        self.GameRadarScore = gameDataDict["gameRadarScore"] as! Dictionary
    }
    
    // MARK: - 请求用户游戏数据
    private func loadUserGameData() {
        guard let userGamePlist = Bundle.main.path(forResource: "UserGameData", ofType: "plist") else {return}
        // 获取属性列表文件中的全部数据
        guard let userGameDict = NSDictionary(contentsOfFile: userGamePlist)! as? [String : Any] else {return}
        guard let userDataDict = userGameDict["\(GameID!)"] as? [String : Any] else {return}
        
        if isLogin {
            // 设置已登录状态的内容
            self.IsUnlock = userDataDict["isUnlock"] as! Int
            self.MaxScoreLabel.text = "\(userDataDict["userGameMaxScore"] as! Int)"
            self.UserGameLevel = "\(userDataDict["userGameLevel"] as! Int)"
            self.UserGameRanking = "\(userDataDict["userRanking"] as! Int)"
            self.UserRadarScore = userDataDict["userRadarScore"] as! Dictionary
            self.UserRankingChange = userDataDict["userRankingChange"] as! Int
            self.UserNickName = Defaults[.userNickName]!
            self.UserHeadImageView.image = UIImage(named: Defaults[.userHeadImageURL]!)
        } else {
            // 设置未登录状态的内容
            self.IsUnlock = 0
            self.MaxScoreLabel.text = "\(0)"
            self.UserGameLevel = "0"
            self.UserRankingLabel.text = "我的排名：0"
            self.UserRadarScore = [
                "reasoningRS" : 0,
                "calculationRS" : 0,
                "inspectionRS" : 0,
                "memoryRS" : 0,
                "spaceRS" : 0,
                "createRS" : 0
            ]
            self.UserRankingChange = 0
            self.UserNickName = ""
            self.UserHeadImageView.image = UIImage(named: "")
        }
    }
    
    /*
    // MARK: - 请求游戏属性数据
    private func loadUserInfoData() {
        //guard let userInfoPlist = Bundle.main.path(forResource: "User", ofType: "plist") else {return}
        // 获取属性列表文件中的全部数据
        //guard let userDataDict = NSDictionary(contentsOfFile: userInfoPlist)! as? [String : Any] else {return}
        
        /// 用户昵称
        self.UserNickName = Defaults[.userNickName]!
        /// 用户头像
        self.UserHeadImageView.image = UIImage(named: Defaults[.userHeadImageURL]!)
    }
    */
}
