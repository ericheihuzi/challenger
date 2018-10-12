//
//  PageJump.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/10.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit

// 进入方式
enum JumpType {
    case push          // PUSH进入
    case present       // 底部弹出进入
    //case normal        // 无跳转动作
    //case pop           // push进入时返回上一页
    //case dismiss       // 关闭当前页面，向下弹走
}

// 退出方式
enum BackType {
    case pop           // 跳转到前一个页面
    case popToRoot     // 返回至最初的ViewController
    case dismiss       // 关闭当前页面，向下弹走
}

// 登录页
let loginSB = UIStoryboard(name: "Login", bundle:nil)
let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController

// 注册页
let signUpSB = UIStoryboard(name: "SignUp", bundle:nil)
let signUpVC = signUpSB.instantiateViewController(withIdentifier: "SignUpTableViewController") as! SignUpTableViewController

// 完善个人信息页
let infoSB = UIStoryboard(name: "AddUserInfo", bundle:nil)
let infoVC = infoSB.instantiateViewController(withIdentifier: "AddUserInfoViewController") as! AddUserInfoViewController

class PageJump {
    /// 跳转到登录页
    class func JumpToLogin(_ type : JumpType) {
        switch type {
        case .push:
            UIViewController.currentViewController()?.navigationController?.pushViewController(loginVC, animated: true)
        case .present:
            UIViewController.currentViewController()?.present(loginVC, animated: true)
        }
    }
    
    /// 跳转到注册页
    class func JumpToSignUp(_ type : JumpType) {
        switch type {
        case .push:
            UIViewController.currentViewController()?.navigationController?.pushViewController(signUpVC, animated: true)
        case .present:
            CBToast.showToastAction(message: "无法使用该方式跳转")
        }
    }
    
    /// 跳转到完善个人信息页
    class func JumpToInfo(_ type : JumpType) {
        switch type {
        case .push:
            UIViewController.currentViewController()?.navigationController?.pushViewController(infoVC, animated: true)
        case .present:
            UIViewController.currentViewController()?.present(infoVC, animated: true)
            //        case .pop:
            //            rootVc?.navigationController?.popViewController(animated: true)
            //        case .dismiss:
            //            rootVc?.dismiss(animated: true, completion: nil)
            //        case .normal: break
        }
    }
    
    /// 退出页面
    class func BackToAny(_ type : BackType) {
        switch type {
        case .pop:
            UIViewController.currentViewController()?.navigationController?.popViewController(animated: true)
        case .popToRoot:
            UIViewController.currentViewController()?.navigationController?.popToRootViewController(animated: true)
        case .dismiss:
            UIViewController.currentViewController()?.dismiss(animated: true, completion: nil)
        }
    }
    
}
