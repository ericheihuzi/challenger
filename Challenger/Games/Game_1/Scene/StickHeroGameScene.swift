//
//  StickHeroGameScene.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/19.
//  Copyright © 2015年 koofrank. All rights reserved.
//

import SpriteKit
import SwiftyUserDefaults

class StickHeroGameScene: SKScene, SKPhysicsContactDelegate {
    fileprivate lazy var levelVM : LocalGameViewModel = LocalGameViewModel()
    fileprivate lazy var gameVM : GameViewModel = GameViewModel()
    
    struct GAP {
        static let XGAP:CGFloat = 20
        static let YGAP:CGFloat = 4
    }
    
    /*
    var gameOver = false {
        willSet {
            if (newValue) {
                print(newValue)
                print("GAME OVER")
                
                checkHighScoreAndStore()
                let gameOverLayer = childNode(withName: StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
                gameOverLayer?.run(SKAction.moveDistance(CGVector(dx: 0, dy: 100), fadeInWithDuration: 0.2))
            }
            
        }
    }
    */
    
    /* 该挑战是通过回合数来判定是否挑战成功，当用户到达的回合数等于该等级规定的回合数时即挑战成功 */
    
    // 用户属性
    var userLevel: Int = Defaults[.StickHeroUserLevel] ?? 0 //用户当前等级，用来计算当前等级的分数
    
    // 游戏属性
    var GameID: String = ""
    var level: Int = 0 //游戏等级数，用来计算当前等级的分数
    var average:Int = 0 //每个等级分数差值，用来计算当前等级的分数
    
    var rescore: Int = 0
    var cascore: Int = 0
    var inscore: Int = 0
    var mescore: Int = 0
    var spscore: Int = 0
    var crscore: Int = 0
    
    var duration: Int = 0 //当前等级间隔时间
    var levelRound: Int = 0 //当前等级回合数
    
    // 音效设置
    var isPlayAudio = true
    
    /* ** ** ** ** *** ** ** ** ** ** ** ** ** ** ** ** ** */
    
    let StackHeight:CGFloat = DefinedScreenHeight / 4 //支架高度
    let StackMaxWidth:CGFloat = 300.0 //支架最大宽度
    let StackMinWidth:CGFloat = 100.0 //支架最小宽度
    let gravity:CGFloat = -100.0 //重力
    let StackGapMinWidth:Int = 80 //支架间隙最小宽度
    
    let HeroSpeed:CGFloat = 500 //人物前进速度
    
    //let StoreScoreName = "com.stickHero.score"
    
    var isBegin = false
    var isEnd = false
    var leftStack:SKShapeNode?
    var rightStack:SKShapeNode?
    
    var nextLeftStartX:CGFloat = 0
    
    let StickWidth:CGFloat = 24 //棒子宽度
    var stickHeight:CGFloat = 0 //棒子高度，初始值为0
    
    var startPointX:CGFloat = DefinedScreenWidth / 2
    var startPointY:CGFloat = DefinedScreenHeight / 2
    
    var round:Int = 0 {
        willSet {
            let scoreBand = childNode(withName: StickHeroGameSceneChildName.ScoreName.rawValue) as? SKLabelNode
            scoreBand?.text = "等级: \(userLevel)" + "  回合: \(newValue)/\(levelRound)"
            scoreBand?.fontName = "HelveticaNeue-bold"
            scoreBand?.run(SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.1), SKAction.scale(to: 1, duration: 0.1)]))
            
            // 如果人物向前走了一格，就隐藏提示语
            if (newValue == 1) {
                let tip = childNode(withName: StickHeroGameSceneChildName.TipBgName.rawValue) as? SKShapeNode
                tip?.run(SKAction.fadeAlpha(to: 0, duration: 0.4))
            }
        }
        
    }
    
    lazy var playAbleRect:CGRect = {
        let maxAspectRatio:CGFloat = 16.0/9.0 // iPhone 5"
        let maxAspectRatioWidth = self.size.height / maxAspectRatio
        let playableMargin = (self.size.width - maxAspectRatioWidth) / 2.0
        return CGRect(x: playableMargin, y: 0, width: maxAspectRatioWidth, height: self.size.height)
    }()
    
    lazy var walkAction:SKAction = {
        var textures:[SKTexture] = []
        for i in 0...1 {
            let texture = SKTexture(imageNamed: "human\(i + 1).png")
            textures.append(texture)
        }
        
        let action = SKAction.animate(with: textures, timePerFrame: 0.15, resize: true, restore: true)
        
        return SKAction.repeatForever(action)
    }()
    
    //MARK: - override
    override init(size: CGSize) {
        super.init(size: size)
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        physicsWorld.contactDelegate = self
    }
    
    override func didMove(to view: SKView) {
        restart()
        
        if isPlayAudio {
            print("音效已开启")
        } else {
            print("音效已关闭")
        }
        
    }
    
    // 点击开始
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /*
        // 判断游戏是否结束，如果结束则点击按钮重新开始
        guard !gameOver else {
            print(!gameOver)
            let gameOverLayer = childNode(withName: StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
            
            let location = touches.first?.location(in: gameOverLayer!)
            let retry = gameOverLayer!.atPoint(location!)
            
            if (retry.name == StickHeroGameSceneChildName.RetryButtonName.rawValue) {
                retry.run(SKAction.sequence([SKAction.setTexture(SKTexture(imageNamed: "button_retry_down"), resize: false), SKAction.wait(forDuration: 0.3)]), completion: {[unowned self] () -> Void in
                    self.restart()
                })
            }
            return
        }
        */
        
        if !isBegin && !isEnd {
            isBegin = true
            //print("点击开始")
            
            //棒子变长
            let stick = loadStick()
            let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
            let action = SKAction.resize(toHeight: CGFloat(DefinedScreenHeight - StackHeight), duration: 1.5)
            stick.run(action, withKey:StickHeroGameSceneActionKey.StickGrowAction.rawValue)
            
            let scaleAction = SKAction.sequence([SKAction.scaleY(to: 0.9, duration: 0.05), SKAction.scaleY(to: 1, duration: 0.05)])
            
            if isPlayAudio {
                let loopAction = SKAction.group([SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickGrowAudioName.rawValue, waitForCompletion: true)])
                stick.run(SKAction.repeatForever(loopAction), withKey: StickHeroGameSceneActionKey.StickGrowAudioAction.rawValue)
            }
            
            hero.run(SKAction.repeatForever(scaleAction), withKey: StickHeroGameSceneActionKey.HeroScaleAction.rawValue)
            
            return
        }
        
    }
    
    //点击结束
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isBegin && !isEnd {
            isEnd  = true
            //print("点击结束")
            
            let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
            hero.removeAction(forKey: StickHeroGameSceneActionKey.HeroScaleAction.rawValue)
            hero.run(SKAction.scaleY(to: 1, duration: 0.04))
            
            let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
            stick.removeAction(forKey: StickHeroGameSceneActionKey.StickGrowAction.rawValue)
            stick.removeAction(forKey: StickHeroGameSceneActionKey.StickGrowAudioAction.rawValue)
            
            if isPlayAudio {
                stick.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickGrowOverAudioName.rawValue, waitForCompletion: false))
            }
            
            //更新棒子长度
            stickHeight = stick.size.height;
            
            //棒子旋转
            let action = SKAction.rotate(toAngle: CGFloat(-Double.pi / 2), duration: 0.4, shortestUnitArc: true)
            
            if isPlayAudio {
                let playFall = SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickFallAudioName.rawValue, waitForCompletion: false)
                stick.run(SKAction.sequence([SKAction.wait(forDuration: 0.2), action, playFall]), completion: {[unowned self] () -> Void in
                    self.heroGo(self.checkPass())
                })
                
            } else {
                stick.run(SKAction.sequence([SKAction.wait(forDuration: 0.2), action]), completion: {[unowned self] () -> Void in
                    self.heroGo(self.checkPass())
                })
            }
            
        }
    }
    
    // 开始游戏
    func start() {
        loadBackground()
        loadTip()
        //loadGameOverLayer()
        loadLocalData(){
            print("用户等级 = \(self.userLevel)")
            print("等级回合 = \(self.levelRound)")
            self.loadScore()
        }
        
        leftStack = loadStacks(false, startLeftPoint: playAbleRect.origin.x)
        self.removeMidTouch(false, left:true)
        loadHero()
        
        let maxGap = Int(playAbleRect.width - StackMaxWidth - (leftStack?.frame.size.width)!)
        
        let gap = CGFloat(randomInRange(self.StackGapMinWidth...maxGap))
        rightStack = loadStacks(false, startLeftPoint: nextLeftStartX + gap)
        
        //gameOver = false
    }
    
    // 重新开始
    func restart() {
        //记录分数
        isBegin = false
        isEnd = false
        round = 0
        nextLeftStartX = 0
        removeAllChildren()
        start()
    }
    
    //检测该次回合是否挑战成功
    fileprivate func checkPass() -> Bool {
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        let rightPoint = startPointX + stick.position.x + self.stickHeight
        
        guard rightPoint < self.nextLeftStartX else {
            return false
        }
        
        guard ((leftStack?.frame)!.intersects(stick.frame) && (rightStack?.frame)!.intersects(stick.frame)) else {
            return false
        }
        
        self.checkTouchMidStack()
        
        return true
    }
    
    fileprivate func checkTouchMidStack() {
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        let stackMid = rightStack!.childNode(withName: StickHeroGameSceneChildName.StackMidName.rawValue) as! SKShapeNode
        
        let newPoint = stackMid.convert(CGPoint(x: -10, y: 10), to: self)
        
        if ((stick.position.x + self.stickHeight) >= newPoint.x  && (stick.position.x + self.stickHeight) <= newPoint.x + 20) {
            loadPerfect()
            
            if isPlayAudio {
                self.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.StickTouchMidAudioName.rawValue, waitForCompletion: false))
            }
            
            //round += 1
            //print("完美 = \(round)")
        }
        
    }
    
    fileprivate func removeMidTouch(_ animate:Bool, left:Bool) {
        let stack = left ? leftStack : rightStack
        let mid = stack!.childNode(withName: StickHeroGameSceneChildName.StackMidName.rawValue) as! SKShapeNode
        if (animate) {
            mid.run(SKAction.fadeAlpha(to: 0, duration: 0.3))
        }
        else {
            mid.removeFromParent()
        }
    }
    
    // 人物向前走，成功后分数+1
    fileprivate func heroGo(_ pass:Bool) {
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        
        guard pass else {
            let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
            
            let dis:CGFloat = stick.position.x + self.stickHeight
            
            let overGap = startPointX - abs(hero.position.x)
            let disGap = nextLeftStartX - overGap - (rightStack?.frame.size.width)! / 2
            
            let move = SKAction.moveTo(x: dis, duration: TimeInterval(abs(disGap / HeroSpeed)))
            
            hero.run(walkAction, withKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
            hero.run(move, completion: {[unowned self] () -> Void in
                stick.run(SKAction.rotate(toAngle: CGFloat(-Double.pi), duration: 0.4))
                
                hero.physicsBody!.affectedByGravity = true
                
                if self.isPlayAudio {
                    hero.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.DeadAudioName.rawValue, waitForCompletion: false))

                }
                
                hero.removeAction(forKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
                //self.run(SKAction.wait(forDuration: 0.5), completion: {[unowned self] () -> Void in
                //self.gameOver = true
                
                self.run(SKAction.wait(forDuration: 0.5), completion: {
                    let vc = StickHeroViewController()
                    vc.showFailureAlert()
                })
            })
            
            return
        }
        
        let dis:CGFloat = nextLeftStartX - startPointX - hero.size.width / 2 - GAP.XGAP
        
        let overGap = startPointX - abs(hero.position.x)
        let disGap = nextLeftStartX - overGap - (rightStack?.frame.size.width)! / 2
        
        let move = SKAction.moveTo(x: dis, duration: TimeInterval(abs(disGap / HeroSpeed)))
        
        hero.run(walkAction, withKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
        hero.run(move, completion: { [unowned self]() -> Void in
            self.round += 1
            print("当前回合 = \(self.round)")
            
            hero.removeAction(forKey: StickHeroGameSceneActionKey.WalkAction.rawValue)
            
            // 如果得分达到目标，则游戏结束并挑战成功
            if self.round >= self.levelRound {
                print("挑战成功")
                //self.gameOver = true
                
                if self.isPlayAudio {
                    self.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.HighScoreAudioName.rawValue, waitForCompletion: false))
                }
                
                // 将计算分数并传到服务器
                self.scoreUpload()
                
            } else {
                if self.isPlayAudio {
                    hero.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.VictoryAudioName.rawValue, waitForCompletion: false))
                }
                
                self.moveStackAndCreateNew()
            }
            
        }) 
    }
    
    fileprivate func scoreUpload() {
        let URES = Int(rescore - self.average * ( self.level - self.userLevel ))
        let UCAS = Int(cascore - self.average * ( self.level - self.userLevel ))
        let UINS = Int(inscore - self.average * ( self.level - self.userLevel ))
        let UMES = Int(mescore - self.average * ( self.level - self.userLevel ))
        let USPS = Int(spscore - self.average * ( self.level - self.userLevel ))
        let UCRS = Int(crscore - self.average * ( self.level - self.userLevel ))
        
        print([URES, UCAS, UINS, UMES, USPS, UCRS])
        
        let challengeTime = Defaults[.challengeTime] ?? 0
        let UploadData: [String: Any] = [
            "gameID": GameID,
            "level" : userLevel,
            "challengeTime": challengeTime,
            "rescore" : URES,
            "cascore" : UCAS,
            "inscore" : UINS,
            "mescore" : UMES,
            "spscore" : USPS,
            "crscore" : UCRS
        ]
        
        let vc = StickHeroViewController()
        gameVM.updateActorInfo(UploadData) { state in
            if state == 0 {
                // 挑战成功后，将挑战信息上传到服务器，用户当前等级+1
                self.userLevel += 1
                Defaults[.StickHeroUserLevel] = self.userLevel
                Defaults[.challengeTime] = challengeTime + 1
                //弹出挑战成功弹窗
                vc.showSuccessAlert()
            } else if state == 4 {
                CBToast.showToastAction(message: "提交失败，请重新登录")
            } else {
                //弹出挑战信息提交失败弹窗
                print("挑战信息提交失败")
            }
        }
    }
    
    /*
    fileprivate func checkHighScoreAndStore() {
        let highScore = UserDefaults.standard.integer(forKey: StoreScoreName)
        if (round > Int(highScore)) {
            showHighScore()
            
            // 将最高分数存入UserDefaults
            UserDefaults.standard.set(round, forKey: StoreScoreName)
            UserDefaults.standard.synchronize()
            
        }
    }
     */
    
    /*
    // 展示高分特效
    fileprivate func showHighScore() {
        if isPlayAudio {
            self.run(SKAction.playSoundFileNamed(StickHeroGameSceneEffectAudioName.HighScoreAudioName.rawValue, waitForCompletion: false))
        }
        
        let wait = SKAction.wait(forDuration: 0.4)
        let grow = SKAction.scale(to: 1.5, duration: 0.4)
        grow.timingMode = .easeInEaseOut
        let explosion = starEmitterActionAtPosition(CGPoint(x: 0, y: 300))
        let shrink = SKAction.scale(to: 1, duration: 0.2)
        
        let idleGrow = SKAction.scale(to: 1.2, duration: 0.4)
        idleGrow.timingMode = .easeInEaseOut
        let idleShrink = SKAction.scale(to: 1, duration: 0.4)
        let pulsate = SKAction.repeatForever(SKAction.sequence([idleGrow, idleShrink]))
        
        let gameOverLayer = childNode(withName: StickHeroGameSceneChildName.GameOverLayerName.rawValue) as SKNode?
        let highScoreLabel = gameOverLayer?.childNode(withName: StickHeroGameSceneChildName.HighScoreName.rawValue) as SKNode?
        highScoreLabel?.run(SKAction.sequence([wait, explosion, grow, shrink]), completion: { () -> Void in
            highScoreLabel?.run(pulsate)
        })
    }
    */
    
    //移除旧stack,创建新的
    fileprivate func moveStackAndCreateNew() {
        let action = SKAction.move(by: CGVector(dx: -nextLeftStartX + (rightStack?.frame.size.width)! + playAbleRect.origin.x - 2, dy: 0), duration: 0.3)
        //右侧支架向左移动
        rightStack?.run(action)
        self.removeMidTouch(true, left:false)
        
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        let stick = childNode(withName: StickHeroGameSceneChildName.StickName.rawValue) as! SKSpriteNode
        
        //人物向左移动
        hero.run(action)
        stick.run(SKAction.group([SKAction.move(by: CGVector(dx: -DefinedScreenWidth, dy: 0), duration: 0.5), SKAction.fadeAlpha(to: 0, duration: 0.3)]), completion: { () -> Void in
            stick.removeFromParent()
        }) 
        
        leftStack?.run(SKAction.move(by: CGVector(dx: -DefinedScreenWidth, dy: 0), duration: 0.5), completion: {[unowned self] () -> Void in
            self.leftStack?.removeFromParent()
            
            let maxGap = Int(self.playAbleRect.width - (self.rightStack?.frame.size.width)! - self.StackMaxWidth)
            let gap = CGFloat(randomInRange(self.StackGapMinWidth...maxGap))
            
            self.leftStack = self.rightStack
            self.rightStack = self.loadStacks(true, startLeftPoint:self.playAbleRect.origin.x + (self.rightStack?.frame.size.width)! + gap)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - load node
private extension StickHeroGameScene {
    // 加载背景图
    func loadBackground() {
        guard let _ = childNode(withName: "background") as! SKSpriteNode? else {
            let texture = SKTexture(image: UIImage(named: "stick_background.jpg")!)
            let node = SKSpriteNode(texture: texture)
            node.size = texture.size()
            node.zPosition = StickHeroGameSceneZposition.backgroundZposition.rawValue
            self.physicsWorld.gravity = CGVector(dx: 0, dy: gravity)
            
            addChild(node)
            return
        }
    }
    
    // 加载分数
    func loadScore() {
        let backY = startPointY - 96 - 36
        let scoreBand = SKLabelNode(fontNamed: "HelveticaNeue-bold")
        scoreBand.name = StickHeroGameSceneChildName.ScoreName.rawValue
        scoreBand.text = "等级: \(userLevel)" + "  回合: 0/\(levelRound)"
        scoreBand.position = CGPoint(x: 0, y: backY + 30)
        scoreBand.fontColor = SKColor.white
        scoreBand.fontSize = 42
        scoreBand.zPosition = StickHeroGameSceneZposition.scoreZposition.rawValue
        scoreBand.horizontalAlignmentMode = .center
        scoreBand.run(SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.1), SKAction.scale(to: 1, duration: 0.1)]))
        addChild(scoreBand)
        
        // 分数的背景
        let back = SKShapeNode(rect: CGRect(x: -startPointX + 150, y: backY, width: DefinedScreenWidth - 300, height: 96), cornerRadius: 48)
        back.zPosition = StickHeroGameSceneZposition.scoreBackgroundZposition.rawValue
        back.fillColor = SKColor.black.withAlphaComponent(0.5) //背景颜色
        back.strokeColor = SKColor.black.withAlphaComponent(0) //描边颜色
        addChild(back)
    }
    
    // 加载提示语
    func loadTip() {
        let tipBgY = startPointY - 96 - 36 - 30 - 96
        let tip = SKLabelNode(fontNamed: "HelveticaNeue")
        tip.name = StickHeroGameSceneChildName.TipName.rawValue
        tip.text = "按住屏幕使竿变长"
        tip.position = CGPoint(x: 0, y: tipBgY + 30)
        tip.fontColor = SKColor.white
        tip.fontSize = 42
        tip.zPosition = StickHeroGameSceneZposition.tipZposition.rawValue
        tip.horizontalAlignmentMode = .center
        
        // 提示语的背景
        let tipWith = CGFloat((tip.text?.count ?? 5) * 42 + 90)
        let tipBg = SKShapeNode(rect: CGRect(x: -startPointX + ((DefinedScreenWidth - tipWith) / 2), y: tipBgY, width: tipWith, height: 96), cornerRadius: 18)
        tipBg.name = StickHeroGameSceneChildName.TipBgName.rawValue
        tipBg.zPosition = StickHeroGameSceneZposition.tipBackgroundZposition.rawValue
        tipBg.fillColor = SKColor.black.withAlphaComponent(0.5) //背景颜色
        tipBg.strokeColor = SKColor.black.withAlphaComponent(0) //描边颜色
        addChild(tipBg)
        tipBg.addChild(tip)
    }
    
    // 加载恭喜特效
    func loadPerfect() {
        defer {
            let perfect = childNode(withName: StickHeroGameSceneChildName.PerfectName.rawValue) as! SKLabelNode?
            let sequence = SKAction.sequence([SKAction.fadeAlpha(to: 1, duration: 0.3), SKAction.fadeAlpha(to: 0, duration: 0.3)])
            let scale = SKAction.sequence([SKAction.scale(to: 1.4, duration: 0.3), SKAction.scale(to: 1, duration: 0.3)])
            perfect!.run(SKAction.group([sequence, scale]))
        }
        
        guard let _ = childNode(withName: StickHeroGameSceneChildName.PerfectName.rawValue) as! SKLabelNode? else {
            let perfect = SKLabelNode(fontNamed: "Arial")
            perfect.text = "完美!"
            perfect.name = StickHeroGameSceneChildName.PerfectName.rawValue
            perfect.position = CGPoint(x: 0, y: 0)
            perfect.fontColor = SKColor.black
            perfect.fontSize = 60
            perfect.zPosition = StickHeroGameSceneZposition.perfectZposition.rawValue
            perfect.horizontalAlignmentMode = .center
            perfect.alpha = 0
            
            addChild(perfect)
            
            return
        }
        
    }
    
    // 加载人物
    func loadHero() {
        let hero = SKSpriteNode(imageNamed: "human1")
        hero.name = StickHeroGameSceneChildName.HeroName.rawValue
        let x:CGFloat = nextLeftStartX - startPointX - hero.size.width / 2 - GAP.XGAP
        let y:CGFloat = StackHeight + hero.size.height / 2 - startPointY - GAP.YGAP
        hero.position = CGPoint(x: x, y: y)
        hero.zPosition = StickHeroGameSceneZposition.heroZposition.rawValue
        hero.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 16, height: 18))
        hero.physicsBody?.affectedByGravity = false
        hero.physicsBody?.allowsRotation = false
        
        addChild(hero)
    }
    
    // 加载棒子
    func loadStick() -> SKSpriteNode {
        let hero = childNode(withName: StickHeroGameSceneChildName.HeroName.rawValue) as! SKSpriteNode
        
        let stick = SKSpriteNode(color: SKColor.black, size: CGSize(width: StickWidth, height: 1))
        stick.zPosition = StickHeroGameSceneZposition.stickZposition.rawValue
        stick.name = StickHeroGameSceneChildName.StickName.rawValue
        stick.color = SKColor.green
        stick.anchorPoint = CGPoint(x: 0.5, y: 0);
        stick.position = CGPoint(x: hero.position.x + hero.size.width / 2 + StickWidth / 2, y: hero.position.y - hero.size.height / 2 - StickWidth / 3)
        addChild(stick)
        
        return stick
    }
    
    // 加载支架
    func loadStacks(_ animate: Bool, startLeftPoint: CGFloat) -> SKShapeNode {
        let max:Int = Int(StackMaxWidth / 10)
        let min:Int = Int(StackMinWidth / 10)
        let width:CGFloat = CGFloat(randomInRange(min...max) * 10)
        let height:CGFloat = StackHeight
        let stack = SKShapeNode(rectOf: CGSize(width: width, height: height))
        stack.fillColor = SKColor.black
        stack.strokeColor = SKColor.black
        stack.zPosition = StickHeroGameSceneZposition.stackZposition.rawValue
        stack.name = StickHeroGameSceneChildName.StackName.rawValue
        
        if (animate) {
            stack.position = CGPoint(x: startPointX, y: -startPointY + height / 2)
            
            stack.run(SKAction.moveTo(x: -startPointX + width / 2 + startLeftPoint, duration: 0.3), completion: {[unowned self] () -> Void in
                self.isBegin = false
                self.isEnd = false
            })
            
        }
        else {
            stack.position = CGPoint(x: -startPointX + width / 2 + startLeftPoint, y: -startPointY + height / 2)
        }
        addChild(stack)
        
        //中间红点
        let mid = SKShapeNode(rectOf: CGSize(width: 20, height: 20))
        mid.fillColor = SKColor.red
        mid.strokeColor = SKColor.red
        mid.zPosition = StickHeroGameSceneZposition.stackMidZposition.rawValue
        mid.name = StickHeroGameSceneChildName.StackMidName.rawValue
        mid.position = CGPoint(x: 0, y: height / 2 - 20 / 2)
        stack.addChild(mid)
        
        nextLeftStartX = width + startLeftPoint
        
        return stack
    }
    
    /*
    // 加载游戏结束
    func loadGameOverLayer() {
        let node = SKNode()
        node.alpha = 0
        node.name = StickHeroGameSceneChildName.GameOverLayerName.rawValue
        node.zPosition = StickHeroGameSceneZposition.gameOverZposition.rawValue
        addChild(node)
        
        let label = SKLabelNode(fontNamed: "HelveticaNeue-Bold")
        label.text = "Game Over"
        label.fontColor = SKColor.red
        label.fontSize = 150
        label.position = CGPoint(x: 0, y: 100)
        label.horizontalAlignmentMode = .center
        node.addChild(label)
        
        let retry = SKSpriteNode(imageNamed: "button_retry_up")
        retry.name = StickHeroGameSceneChildName.RetryButtonName.rawValue
        retry.position = CGPoint(x: 0, y: -200)
        node.addChild(retry)
        
        let highScore = SKLabelNode(fontNamed: "AmericanTypewriter")
        highScore.text = "Highscore!"
        highScore.fontColor = UIColor.white
        highScore.fontSize = 50
        highScore.name = StickHeroGameSceneChildName.HighScoreName.rawValue
        highScore.position = CGPoint(x: 0, y: 300)
        highScore.horizontalAlignmentMode = .center
        highScore.setScale(0)
        node.addChild(highScore)
    }
    */
    
    //MARK: - Action
    func starEmitterActionAtPosition(_ position: CGPoint) -> SKAction {
        let emitter = SKEmitterNode(fileNamed: "StarExplosion")
        emitter?.position = position
        emitter?.zPosition = StickHeroGameSceneZposition.emitterZposition.rawValue
        emitter?.alpha = 0.6
        addChild((emitter)!)
        
        let wait = SKAction.wait(forDuration: 0.15)
        
        return SKAction.run({ () -> Void in
            emitter?.run(wait)
        })
    }
    
}

//MARK: - load data
private extension StickHeroGameScene {
    // MARK:- 加载本地游戏配置
    func loadLocalData(finishedCallback : @escaping () -> ()) {
        // 加载等级信息
        levelVM.localGameLevel(userLevel, GameID) { dict in
            let levelModel = LevelModel(dict: dict)
            self.duration = levelModel.duration
            self.levelRound = levelModel.round
            self.userLevel = Defaults[.StickHeroUserLevel] ?? 0
        }
        
        finishedCallback()
    }
    
}
