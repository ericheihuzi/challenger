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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入APP")
        print("用户uuid：\(UUID())")
        print("用户nsuuid：\(NSUUID())")
        print("用户ID：\(Defaults[.userID])")
        
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
