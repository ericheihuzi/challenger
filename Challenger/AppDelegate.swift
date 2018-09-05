//
//  AppDelegate.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //应用程序启动后自定义的重载点。
        
        return true
    }
    /*
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        if self.blockRotation{
            return UIInterfaceOrientationMask.all
            
        } else {
            return UIInterfaceOrientationMask.portrait
        }
    }
    */
    func applicationWillResignActive(_ application: UIApplication) {
        // 当应用程序即将从活动状态转移到非活动状态时发送。这可能发生在某些类型的临时中断（如传入的电话或SMS消息）中，或者当用户退出应用程序时，它开始过渡到后台状态。
        // 使用此方法暂停正在执行的任务，禁用定时器，并使图形呈现回调无效。游戏应该用这个方法暂停游戏。
        //print("applicationWillResignActive 被执行了")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // 使用此方法释放共享资源、保存用户数据、使定时器无效，并存储足够的应用程序状态信息，以便在以后终止应用程序时将应用程序恢复到当前状态。
        // 如果您的应用程序支持后台执行，则该方法被调用而不是Apple将终止：当用户退出时。
        //print("applicationDidEnterBackground 被执行了")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // 作为从后台到活动状态的转换的一部分调用；在这里可以撤消在进入后台时所做的许多更改。
        //print("applicationWillEnterForeground 被执行了")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // 重新启动在应用程序处于非活动状态时暂停（或尚未启动）的任何任务。如果应用程序先前位于后台，则可选地刷新用户界面。
        //print("applicationDidBecomeActive 被执行了")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // 当应用程序即将终止时调用。 保存数据，如果合适的话。参见applicationDidEnterBackground。
        //print("applicationWillTerminate 被执行了")
    }

}
