//
//  GameViewController.swift
//  Stick-Hero
//
//  Created by 顾枫 on 15/6/19.
//  Copyright (c) 2015年 koofrank. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation
import SwiftyUserDefaults

var stickHeroScene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))

class StickHeroViewController: UIViewController {
    var musicPlayer:AVAudioPlayer!
    @IBOutlet var skView: SKView!
    @IBOutlet var PauseButton: UIButton!
    
    fileprivate lazy var localVM : LocalGameViewModel = LocalGameViewModel()
    fileprivate lazy var gameInfoVM : GameViewModel = GameViewModel()
    
    var GameID: String = ""
    var isPlayBgMusicText: String = "已关闭"
    var isPlayAudioText: String = "已关闭"
    var userLevel: Int = 1
    
    var infoModel: GameInfoModel?
    
    var isPlayBgMusic = false {
        didSet {
            musicPlayer = setupAudioPlayerWithFile("bg_country", type: "mp3")
            musicPlayer.numberOfLoops = -1
            if isPlayBgMusic {
                musicPlayer.play()
                isPlayBgMusicText = "已开启"
            } else {
                musicPlayer.stop()
                isPlayBgMusicText = "已关闭"
            }
        }
    }
    
    var isPlayAudio = false {
        didSet {
            if isPlayAudio {
                stickHeroScene.isPlayAudio = true
                isPlayAudioText = "已开启"
            } else {
                stickHeroScene.isPlayAudio = false
                isPlayAudioText = "已关闭"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //PauseButton.isEnabled = true
        
        //let scene = StickHeroGameScene(size:CGSize(width: DefinedScreenWidth, height: DefinedScreenHeight))
        
        // Configure the view.
        //skView.showsFPS = true
        //skView.showsNodeCount = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        //scene.scaleMode = .aspectFill
        stickHeroScene.scaleMode = .aspectFill
        
        loadLocalData() {
            self.skView.presentScene(stickHeroScene)
        }
        
    }
    
    @IBAction func pause(_ sender: Any) {
        showPauseAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isPlayBgMusic = Defaults[.isPlayBgMusic]
        isPlayAudio   = Defaults[.isPlayAudio]
    }
    
    func showPauseAlert() {
        //print("暂停中")
        let alert = UIAlertController(style: .alert, title: "暂停中")
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_continue"), title: "继续挑战", color: Theme.MainColor, style: .cancel) {_ in
            print("继续挑战")
        }
        
        //color UIColor(hex: 0xFF2DC6)
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_restart"), title: "重新挑战", color: Theme.MainColor, style: .default) {_ in
            print("重新开始")
            stickHeroScene.restart()
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_help"), title: "挑战介绍", color: Theme.MainColor, style: .default) {_ in
            print("挑战介绍")
            let webSB = UIStoryboard(name: "WebView", bundle:nil)
            let webVC = webSB.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            webVC.titleStr = "挑战介绍"
            webVC.url = "\(RequestHome)\(RequestGameHelp)" + self.GameID
            self.present(webVC, animated: true)
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_volume"), title: "音效设置 (\(isPlayAudioText))", color: Theme.MainColor, style: .default) {_ in
            if self.isPlayAudio {
                self.isPlayAudio = false
                Defaults[.isPlayAudio] = self.isPlayAudio
            } else {
                self.isPlayAudio = true
                Defaults[.isPlayAudio] = self.isPlayAudio
            }
            
            print("游戏音效 = \(self.isPlayAudioText)")
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_bgm"), title: "背景音乐 (\(isPlayBgMusicText))", color: Theme.MainColor, style: .default) {_ in
            if self.isPlayBgMusic {
                self.isPlayBgMusic = false
                Defaults[.isPlayBgMusic] = self.isPlayBgMusic
            } else {
                self.isPlayBgMusic = true
                Defaults[.isPlayBgMusic] = self.isPlayBgMusic
            }
            
            print("背景音乐 = \(self.isPlayBgMusicText)")
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_quit"), title: "退出挑战", color: Theme.MainColor, style: .destructive) {_ in
            UIViewController.currentViewController()?.dismiss(animated: true, completion: nil)
        }
        
        alert.show()
    }
    
    func showSuccessAlert() {
        //print("挑战成功")
        let alert = UIAlertController(style: .alert, title: "挑战成功")
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_nextlevel"), title: "下一关", color: Theme.MainColor, style: .default) {_ in
            print("下一关")
            stickHeroScene.restart()
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_quit"), title: "退出挑战", color: Theme.MainColor, style: .destructive) {_ in
            UIViewController.currentViewController()?.dismiss(animated: true, completion: nil)
        }
        
        alert.show()
    }
    
    func showFailureAlert() {
        //print("挑战失败")
        let alert = UIAlertController(style: .alert, title: "挑战失败")
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_restart"), title: "重新挑战", color: Theme.MainColor, style: .default) {_ in
            print("重新挑战")
            stickHeroScene.restart()
        }
        
        alert.addAction(image: #imageLiteral(resourceName: "icon_menu_quit"), title: "退出挑战", color: Theme.MainColor, style: .destructive) {_ in
            UIViewController.currentViewController()?.dismiss(animated: true, completion: nil)
        }
        
        alert.show()
    }
    
    func setupAudioPlayerWithFile(_ file:NSString, type:NSString) -> AVAudioPlayer  {
        let url = Bundle.main.url(forResource: file as String, withExtension: type as String)
        var audioPlayer:AVAudioPlayer?
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
        } catch {
            print("NO AUDIO PLAYER")
        }
        
        return audioPlayer!
    }
    
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

extension StickHeroViewController {
    // MARK:- 加载游戏数据
    fileprivate func loadLocalData(finishedCallback : @escaping () -> ()) {
        stickHeroScene.userLevel = userLevel
        stickHeroScene.level   = infoModel?.level ?? 0
        stickHeroScene.average = 2 //infoModel?.average ?? 0
        stickHeroScene.rescore = infoModel?.rescore ?? 0
        stickHeroScene.cascore = infoModel?.cascore ?? 0
        stickHeroScene.inscore = infoModel?.inscore ?? 0
        stickHeroScene.mescore = infoModel?.mescore ?? 0
        stickHeroScene.spscore = infoModel?.spscore ?? 0
        stickHeroScene.crscore = infoModel?.crscore ?? 0
        stickHeroScene.GameID = self.GameID
        
        finishedCallback()
    }
    
}
