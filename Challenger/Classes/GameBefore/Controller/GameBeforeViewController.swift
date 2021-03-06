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
import Kingfisher

class GameBeforeViewController: UIViewController {
    
    // 隐藏状态栏
    //override var prefersStatusBarHidden: Bool {
    //    return true
    //}
    
    // 修改状态栏的样式为白色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - 懒加载属性
    fileprivate lazy var gameInfoVM : GameViewModel = GameViewModel()
    //fileprivate lazy var userGameVM : GameViewModel = GameViewModel()
    
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
    
    @IBOutlet var RELabel: UILabel! //推理力
    @IBOutlet var CALabel: UILabel! //计算力
    @IBOutlet var INLabel: UILabel! //视察力
    @IBOutlet var MELabel: UILabel! //记忆力
    @IBOutlet var SPLabel: UILabel! //空间力
    @IBOutlet var CRLabel: UILabel! //创造力
    
    @IBOutlet var MaxScoreLabel: UILabel! //用户最高分
    //@IBOutlet var NewScoreLabel: UILabel! //用户最新分
    @IBOutlet var LevelLabel: UILabel! //挑战等级：用户/游戏
    
    /* ** ** ** ** *** ** ** ** 传值过来的数据 ** ** ** ** ** ** ** ** ** */
    var ReceiveData: [String: Any] = [
        //游戏数据
        "gameID": "",
        "gameTitle": "挑战名称",
        "gameColor": "#fff34dba",
        "category": 0,
        "level": 0,
        "coverName": "",
        "chartGS": [0,0,0,0,0,0],
        "chartUS": [0,0,0,0,0,0],
        "GRES": 0,
        "GCAS": 0,
        "GINS": 0,
        "GMES": 0,
        "GSPS": 0,
        "GCRS": 0,
        
        //用户数据
        "userLevel": 1,
        "ranking": 0,
        "rankingChange": 0,
        "nickName": "",
        "URES": 0,
        "UCAS": 0,
        "UINS": 0,
        "UMES": 0,
        "USPS": 0,
        "UCRS": 0
    ]
    
    /* ** ** ** ** *** ** ** ** 游戏数据 ** ** ** ** ** ** ** ** ** */
    //var GameLevel: Int = 0 // 游戏挑战等级
    //var GameCategory: String = "" //游戏挑战类型
    //var GameID : String = "" //游戏ID
    //游戏雷达数据
    //var GRES: Int = 0
    //var GCAS: Int = 0
    //var GINS: Int = 0
    //var GMES: Int = 0
    //var GSPS: Int = 0
    //var GCRS: Int = 0
    
    // 定义游戏信息属性
//    var gameInfo : GameInfoModel? {
//        didSet {
//            /// 游戏名称
//            self.GameTitle.text = gameInfo?.title
//            /// 参与人数
//            //self.PeopleNum.text = "\(gameInfo?.join ?? 0)人参与"
//            /// 游戏封面图
//            let headPath = "\(RequestHome)\(RequestGameCover)"
//            let coverName = gameInfo?.coverName ?? ""
//            let gameCover = URL(string: headPath + coverName)
//            self.GameCover.kf.setImage(with: gameCover, placeholder: UIImage(named: ""))
//            ///挑战类型
//            //self.GameCategory = gameInfo?.category ?? ""
//            ///游戏等级数量
//            self.GameLevel = gameInfo?.level ?? 0
//            ///雷达数据
//            self.GRES = gameInfo?.rescore ?? 0
//            self.GCAS = gameInfo?.cascore ?? 0
//            self.GINS = gameInfo?.inscore ?? 0
//            self.GMES = gameInfo?.mescore ?? 0
//            self.GSPS = gameInfo?.spscore ?? 0
//            self.GCRS = gameInfo?.crscore ?? 0
//        }
//    }
    
    /* ** ** ** ** *** ** ** ** 用户游戏数据 ** ** ** ** ** ** ** ** ** */
//    var UserGameLevel: Int = 0 //用户挑战等级
//    var UserGameRanking: Int = 0 //用户排名
//    var UserRankingChange: Int = 0 //用户排名变化
//    var IsPay: Int = 0 //是否解锁
//    var NewScore: Int = 0 //最新分数
//    // 用户雷达数据
//    var URES: Int = 0
//    var UCAS: Int = 0
//    var UINS: Int = 0
//    var UMES: Int = 0
//    var USPS: Int = 0
//    var UCRS: Int = 0
//
//    // 定义游戏信息属性
//    var userGame : UserGameModel? {
//        didSet {
//            ///是否解锁：0-未解锁，1-已解锁
//            self.IsPay = userGame?.ispay ?? 0
//            ///用户等级
//            self.UserGameLevel = userGame?.level ?? 0
//            ///用户排名
//            //self.UserGameRanking = userGame?.ranking ?? 0
//            ///排名变化
//            self.UserRankingChange = userGame?.rankingChange ?? 0
//            ///最新分数
//            //self.NewScoreLabel = "\(userGame?.newscore ?? 0)"
//            ///最高分数
//            self.MaxScoreLabel.text = "\(userGame?.maxscore ?? 0)"
//            ///雷达数据
//            self.URES = userGame?.rescore ?? 0
//            self.UCAS = userGame?.cascore ?? 0
//            self.UINS = userGame?.inscore ?? 0
//            self.UMES = userGame?.mescore ?? 0
//            self.USPS = userGame?.spscore ?? 0
//            self.UCRS = userGame?.crscore ?? 0
//        }
//    }
    
    /* ** ** ** ** *** ** ** ** 用户账户数据 ** ** ** ** ** ** ** ** ** */
    //var UserNickName: String = "" //用户昵称
    
    // 挑战等级页面属性
    var LevelBackground: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入游戏详情页")
        print("gameID = \(ReceiveData["gameID"] as! String)")
        print("ReceiveData = \(ReceiveData)")
        
        // 加载数据
        //loadData()
        
        // 设置UI
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 动态设置状态栏风格,透明导航栏
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //loadUserAccountData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    @IBAction func unwindToGameBeforeViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startChallenge(_ sender: UIButton) {
        let GameID = ReceiveData["gameID"] as! String
        
        if Defaults[.isLogin] {
            if GameID == "IN-0001" {
                let gameSB = UIStoryboard(name: "StickHero", bundle:nil)
                let gameVC = gameSB.instantiateViewController(withIdentifier: "StickHeroViewController") as! StickHeroViewController
                gameVC.GameID = GameID
                
                // 请求游戏数据
                gameInfoVM.loadGameInfo(GameID) { dict in
                    let gameInfoData = GameInfoModel(dict: dict)
                    let userLevel = self.ReceiveData["userLevel"] as? Int ?? 1
                    gameVC.infoModel = gameInfoData
                    gameVC.userLevel = userLevel
                    self.present(gameVC, animated: true)
                }
            } else {
                CBToast.showToastAction(message: "敬请期待")
            }
        } else {
            CBToast.showToastAction(message: "您还没有登录")
        }
    }
    
    @IBAction func getHelp(_ sender: UIButton) {
        let webSB = UIStoryboard(name: "WebView", bundle:nil)
        let webVC = webSB.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        let GameID = ReceiveData["gameID"] as? String ?? ""
        
        webVC.titleStr = "挑战介绍"
        //webVC.type = .local
        webVC.url = "\(RequestHome)\(RequestGameHelp)" + GameID
        //webVC.htmlName = "test"
        self.present(webVC, animated: true)
    }
    
    // 进入排行榜
    @IBAction func toGameRanking(_ sender: Any) {
        let rankingSB = UIStoryboard(name: "GameRanking", bundle:nil)
        let rankingVC = rankingSB.instantiateViewController(withIdentifier: "GameRankingViewController") as! GameRankingViewController
        rankingVC.GameID = ReceiveData["gameID"] as? String
        self.present(rankingVC, animated: true)
    }
    
    /*
     // 监听屏幕旋转
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     super.viewWillTransition(to: size, with: coordinator)
     coordinator.animate(alongsideTransition: { context in
     //self.setBackground()
     }, completion: nil)
     }
     */
    
}

// MARK:- 设置UI界面
extension GameBeforeViewController {
    private func setupUI() {
        /// 设置导航栏
        setupNavigationBar()
        /// 设置内容UI
        setGameDetail()
        /// 判断挑战类型,并设置UI风格
        self.judgeChallengeType()
        /// 配置UI内容
        self.setUIData()
    }
    private func setupNavigationBar() {
        /// 设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        /// 设置标题
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        //self.navigationController?.navigationBar.topItem?.title = "\(String(describing: gameTitle))"
    }
    
    // MARK: - 传值Container View的UI属性
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChartViewSegue" {
            print("---------------- 图表数据 ----------------")
            let chartVC = segue.destination as! GameBeforeChartViewController
            chartVC.myDataColor = ReceiveData["gameColor"] as! String
            chartVC.GS = ReceiveData["chartGS"] as! [Int]
            chartVC.US = ReceiveData["chartUS"] as! [Int]
            
        } else if segue.identifier == "RankingViewSegue" {
            let rankingVC = segue.destination as! GameWorldRankingViewController
            rankingVC.GameID = ReceiveData["gameID"] as? String ?? "" //GameID
            rankingVC.gameColor = ReceiveData["gameColor"] as? String ?? ""
            rankingVC.nickName = ReceiveData["nickName"] as? String ?? ""
            
        } else if segue.identifier == "showGameLevelSegue" {
            let levelVC = segue.destination as! GameLevelViewController
            levelVC.LevelBackgroundImage = LevelBackground!
            levelVC.gameLevel = ReceiveData["level"] as? Int ?? 0
            levelVC.userLevel = ReceiveData["userLevel"] as? Int ?? 1
        }
    }
    
    private func judgeChallengeType() {
        let category = ReceiveData["category"] as? String
        
        if category == "reasoning" {
            setGameStyle("#fff34dba", "#ffc643fb", "#00c643fb", "reasoning_bg")
        } else if category == "calculation" {
            setGameStyle("#ff86fc6f", "#ff0cd318", "#000cd318", "calculation_bg")
        } else if category == "inspection" {
            setGameStyle("#ffffc000", "#ffff7800", "#00ff7800", "inspection_bg")
        } else if category == "memory" {
            setGameStyle("#ffc644fc", "#ff5856d6", "#005856d6", "memory_bg")
        } else if category == "space" {
            setGameStyle("#ff1ad5fd", "#ff1d64f0", "#001d64f0", "space_bg")
        } else if category == "create" {
            setGameStyle("#ffff5e3a", "#ffff2a68", "#00ff2a68", "create_bg")
        } else {
            setGameStyle("#fff34dba", "#ffc643fb", "#00c643fb", "reasoning_bg")
        }
    }
    
    private func setGameStyle(_ colorStart: String, _ colorEnd: String, _ colorAlpha: String, _ backgroundImage: String) {
        
        /// 加载数据：背景色
        self.view.backgroundColor = UIColorTemplates.colorFromString(colorEnd)
        BackgroundImage.image = UIImage(named: backgroundImage)
        
        /*
         let gradientContent = gradientBackground("#ff33dd00", "#ff339900")
         //gradientContent.frame.size = ContentView.frame.size
         gradientContent.frame.size = CGSize(width: kScreenH, height: kScreenH)
         ContentView.layer.insertSublayer(gradientContent, at: 0)
         */
        
        /// 加载数据：开始游戏按钮的背景渐变色
        let gradientView = gradientBackground(colorAlpha, colorEnd)
        //gradientView.frame.size = ButtonBGView.frame.size
        gradientView.frame.size = CGSize(width: kScreenW, height: 64)
        ButtonBGView.layer.insertSublayer(gradientView, at: 0)
        
        /// 加载数据：开始按钮样式
        StartGameButton.layer.shadowColor = UIColorTemplates.colorFromString(colorEnd).cgColor
        StartGameButton.setTitleColor(UIColorTemplates.colorFromString(colorEnd), for: .normal)
        
        GameCover.backgroundColor = UIColorTemplates.colorFromString(colorEnd)
        ContentView.backgroundColor = UIColorTemplates.colorFromString(colorStart)
        /// 设置游戏等级界面(GameLevelViewController)的背景图
        self.LevelBackground = backgroundImage
    }
    
    private func setGameDetail() {
        /// 添加虚线
        dashedLine()
        /// 游戏介绍与玩法演示按钮样式
        gameIntroduction.layer.borderColor = UIColor.white.cgColor
        /// 开始游戏按钮样式
        StartGameButton.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        StartGameButton.layer.shadowOpacity = 0.8
        /// 查看全部按钮样式
        watchALL.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
    }
    
    private func setUIData() {
        /// 配置游戏数据
        let GameID = ReceiveData["gameID"] as? String ?? ""
        let gameTitle = ReceiveData["gameTitle"] as? String ?? ""
        let coverName = ReceiveData["coverName"] as? String ?? ""
        let gameLevel = ReceiveData["level"] as? Int ?? 0
        //let join = ReceiveData["join"] as? Int ?? 0
        
        let GRES = ReceiveData["GRES"] as? Int ?? 0
        let GCAS = ReceiveData["GCAS"] as? Int ?? 0
        let GINS = ReceiveData["GINS"] as? Int ?? 0
        let GMES = ReceiveData["GMES"] as? Int ?? 0
        let GSPS = ReceiveData["GSPS"] as? Int ?? 0
        let GCRS = ReceiveData["GCRS"] as? Int ?? 0
        
        /// 配置用户数据
        let userLevel = ReceiveData["userLevel"] as? Int ?? 1
        //let ranking = ReceiveData["ranking"] as? Int ?? 0
        
        let URES = ReceiveData["URES"] as? Int ?? 0
        let UCAS = ReceiveData["UCAS"] as? Int ?? 0
        let UINS = ReceiveData["UINS"] as? Int ?? 0
        let UMES = ReceiveData["UMES"] as? Int ?? 0
        let USPS = ReceiveData["USPS"] as? Int ?? 0
        let UCRS = ReceiveData["UCRS"] as? Int ?? 0
        
        let US = ReceiveData["chartUS"] as? [Int] ?? [0,0,0,0,0]
        let maxScore = US.max() ?? 0
        
        /// 游戏名称
        self.GameTitle.text = gameTitle
        /// 参与人数
        gameInfoVM.loadGameJoin(GameID) { join in
            self.PeopleNum.text = "\(join)人参与"
        }
        
        /// 游戏封面图
        let coverPath = "\(RequestHome)\(RequestGameCover)"
        let gameCover = URL(string: coverPath + coverName)
        self.GameCover.kf.setImage(with: gameCover, placeholder: UIImage(named: ""))
        ///
        self.MaxScoreLabel.text = "\(maxScore)"
        
        /// 设置挑战等级
        self.LevelLabel.text = "\(userLevel)" + "/" + "\(gameLevel)"
        /// 设置雷达数据
        self.RELabel.text = "\(URES)" + "/" + "\(GRES)"
        self.CALabel.text = "\(UCAS)" + "/" + "\(GCAS)"
        self.INLabel.text = "\(UINS)" + "/" + "\(GINS)"
        self.MELabel.text = "\(UMES)" + "/" + "\(GMES)"
        self.SPLabel.text = "\(USPS)" + "/" + "\(GSPS)"
        self.CRLabel.text = "\(UCRS)" + "/" + "\(GCRS)"
        
    }
    
    
    // 虚线样式
    private func dashedLine() {
        /// 顶部虚线
        dashedLineView.layer.addSublayer(drawDashLine(dashedLineView))
        dashedLineView.backgroundColor = UIColor.clear
        /// 能力维度标题右侧虚线
        dashedLineView2.layer.addSublayer(drawDashLine(dashedLineView2))
        dashedLineView2.backgroundColor = UIColor.clear
        /// 世界排名标题右侧虚线
        dashedLineView3.layer.addSublayer(drawDashLine(dashedLineView3))
        dashedLineView3.backgroundColor = UIColor.clear
    }
    
    // 绘制虚线
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
    
    // 绘制渐变背景
    private func gradientBackground(_ startColor: String, _ endColor: String) -> CAGradientLayer {
        /// 定义渐变的颜色（从黄色渐变到橙色）
        let Color1 = UIColorTemplates.colorFromString(startColor)
        let Color2 = UIColorTemplates.colorFromString(endColor)
        let gradientColors = [Color1.cgColor, Color2.cgColor]
        
        /// 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        /// 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        /// 设置渲染的起始结束位置
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        /// 设置其CAGradientLayer对象的frame，并插入view的layer
        //gradientLayer.frame = self.view.bounds
        return gradientLayer
    }
    
}

/*
// MARK:- 配置数据
extension GameBeforeViewController {
    // 加载数据
    private func loadData() {
        //loadGameInfoData()
    }
    
    private func loadGameInfoData() {
        let GameID = ReceiveData["gameID"] as! String
        
        // 请求游戏数据
        gameInfoVM.loadGameInfo(GameID) { dict in
            let gameInfoData = GameInfoModel(dict: dict)
            self.gameInfo = gameInfoData
        }
        
        // 请求用户游戏数据
        userGameVM.loadUserGame(GameID) { dict2 in
            let userGameData = UserGameModel(dict: dict2)
            self.userGame = userGameData
            
            // 配置UI内容
            self.setUIData()
        }
        
        // 请求用户账户数据
        loadUserAccountData()
        
        // 请求参与人数
        gameInfoVM.loadGameJoin(GameID) { join in
            self.PeopleNum.text = "\(join)人参与"
        }
        
    }
    
    private func loadUserAccountData() {
        self.UserNickName = Defaults[.nickName]!
        // 设置头像
        //拼接头像路径
        let headPath = "\(RequestHome)\(RequestUserHeadImage)"
        let headImageURL = URL(string: headPath + Defaults[.picName]!)
        
        if Defaults[.sex] == 2 {
            self.UserHeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
        } else {
            self.UserHeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
        }
    }
    
}
 */

