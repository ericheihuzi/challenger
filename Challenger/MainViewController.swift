//
//  MainViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/25.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class MainViewController: UITabBarController {
    
    var activityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入APP")
        //print("用户uuid：\(UUID())")
        //print("用户nsuuid：\(NSUUID())")
        print("用户ID：\(Defaults[.userID] ?? "")")
        print("用户昵称：\(Defaults[.nickName] ?? "----")")
        //Defaults[.isLogin] = false
        //loadData()
        //print("用户ID：\(Defaults[.userID])")
        //print("用户昵称：\(Defaults[.userNickName] ?? "----")")
        
        loadData()
        
        // force load
        //_ = GitHubSearchRepositoriesAPI.sharedAPI
        //_ = DefaultWikipediaAPI.sharedAPI
        //_ = DefaultImageService.sharedImageService
        //_ = DefaultWireframe.shared
        //_ = MainScheduler.instance
        //_ = Dependencies.sharedDependencies.reachabilityService
        
        /*
        let geoService = GeolocationService.instance
        geoService.authorized.drive(onNext: { _ in
         
        }).dispose()
        geoService.location.drive(onNext: { _ in
         
        }).dispose()
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MainViewController {
    private func loadData() {
        loadStateUI()
        loadingIndicator()
    }
    
    private func loadStateUI() {
        // 判断token，若已失效，弹出登录页，若未失效，请求用户信息和挑战信息
        RequestJudgeState.judgeTokenAccess() {
            // 请求userInfo
            RequestJudgeState.judgeLoadUserInfo(.present, .yes){ infoSta in
                if infoSta == 0 || infoSta == 1 {
                    // 请求challengeInfo
                    RequestJudgeState.judgeLoadChallengeInfo(.present){ ChaSta in
                        if ChaSta == 0 || ChaSta == 1 {
                            //进度条停止转动
                            self.activityIndicator.stopAnimating()
                        } else {
                            DispatchAfter(after: 10) {
                                //进度条停止转动
                                self.activityIndicator.stopAnimating()
                            }
                        }
                    }
                    
                } else {
                    DispatchAfter(after: 10) {
                        //进度条停止转动
                        self.activityIndicator.stopAnimating()
                    }
                }
            }
        }
    
    }

    func loadingIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        self.view.addSubview(activityIndicator)
        
        //进度条开始转动
        activityIndicator.startAnimating()
        
        DispatchAfter(after: 20) {
            //进度条停止转动
            self.activityIndicator.stopAnimating()
        }
    }

}
