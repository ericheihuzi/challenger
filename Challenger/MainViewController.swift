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

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入APP")
        
        // force load
        //_ = GitHubSearchRepositoriesAPI.sharedAPI
        //_ = DefaultWikipediaAPI.sharedAPI
        //_ = DefaultImageService.sharedImageService
        _ = DefaultWireframe.shared
        _ = MainScheduler.instance
        //_ = Dependencies.sharedDependencies.reachabilityService
        
        /*
        let geoService = GeolocationService.instance
        geoService.authorized.drive(onNext: { _ in
            
        }).dispose()
        geoService.location.drive(onNext: { _ in
            
        }).dispose()
        */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
