//
//  RequestJudgeState.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/6.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

enum EntryType {
    case push
    case present
    case normal
}

enum DismissType {
    case yes
    case no
}

class RequestJudgeState {
    
    /// 判断loadUserInfo状态
    /// type: 弹出*完善个人信息页面*的方式
    /// dismiss: 是否关闭当前页面
    class func judgeLoadUserInfo(_ type: EntryType, _ dismiss: DismissType) {
        let infoSB = UIStoryboard(name: "AddUserInfo", bundle:nil)
        let infoVC = infoSB.instantiateViewController(withIdentifier: "AddUserInfoViewController") as! AddUserInfoViewController
        let rootVc = UIViewController.currentViewController()
        
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        
        // value: 0-成功，1-用信息为空
        infoVM.loadUserInfo {
            let loadStatusValue = infoVM.loadStatusValue
            
            if loadStatusValue == 0 {
                if dismiss == .yes {
                    //CBToast.showToastAction(message: "获取个人信息成功")
                    rootVc?.dismiss(animated: true, completion: nil)
                } else {
                    print("不关闭当前页")
                }
            } else if loadStatusValue == 1 {
                // 若用户信息为空则弹出*完善个人信息页面*
                if type == .present {
                    rootVc?.present(infoVC, animated: true)
                } else if type == .push {
                    rootVc?.navigationController?.pushViewController(infoVC, animated: true)
                } else {
                    print("无界面跳转事件")
                }
            }else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断updateUserInfo状态
    /// type: 弹出*完善个人信息页面*的方式
    class func judgeUpdateUserInfo(_ dict: [String : Any]) {
        let rootVc = UIViewController.currentViewController()
        
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        //infoVM.userInfoUpdate = dict
        
        // value: 0-成功，4-token已失效，请重新登录
        infoVM.updateUserInfo(dict) {
            let updateStatusValue = infoVM.updateStatusValue
            
            if updateStatusValue == 0 {
                CBToast.showToastAction(message: "更新成功")
                //请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.normal, .yes)
            } else if updateStatusValue == 4 {
                rootVc?.dismiss(animated: true, completion: nil)
            }else {
                CBToast.showToastAction(message: "未知错误")
                rootVc?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    /// 判断登录状态
    class func judgeLogin(_ account: String, _ password: String) {
        let LoginVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        LoginVM.account = account
        LoginVM.password = password
        
        // value: 0-成功，22-密码错误，21-用户不存在
        LoginVM.login {
            let loginStatusValue = LoginVM.loginStatusValue
            
            if loginStatusValue == 0 {
                CBToast.showToastAction(message: "登录成功")
                Defaults[.account] = LoginVM.account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                //请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.push, .yes)
                
            } else if loginStatusValue == 22 {
                CBToast.showToastAction(message: "密码错误")
            } else if loginStatusValue == 21 {
                CBToast.showToastAction(message: "用户不存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断注册状态
    class func judgeRegister(_ account: String, _ password: String) {
        let registerVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        registerVM.account = account
        registerVM.password = password
        
        // value: 0-成功，20-用户已存在，1-失败，条件不足，无法注册
        registerVM.register {
            let registerStatusValue = registerVM.registerStatusValue
            
            if registerStatusValue == 0 {
                CBToast.showToastAction(message: "注册成功")
                Defaults[.account] = registerVM.account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                //请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.push, .yes)
                
            } else if registerStatusValue == 1 {
                CBToast.showToastAction(message: "注册失败")
            } else if registerStatusValue == 20 {
                CBToast.showToastAction(message: "用户已存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断修改密码状态
    class func judgeChangePassword(_ account: String, _ password: String, _ newPassword: String) {
        let changeVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        changeVM.account = account
        changeVM.password = password
        changeVM.newPassword = newPassword
        
        // value: 0-成功，22-密码不正确
        changeVM.changePassword {
            let changeStatusValue = changeVM.changeStatusValue
            
            let rootVc = UIViewController.currentViewController()
            
            if changeStatusValue == 0 {
                CBToast.showToastAction(message: "修改成功")
                //返回上一页
                rootVc?.navigationController?.popViewController(animated: true)
                
                //延迟2秒执行退出登录：如果不设置延迟，弹窗会很快就消失
                //DispatchAfter(after: 2) {
                    //退出登录
                    //RequestJudgeState.judgeExit(.present)
                //}
                
            } else if changeStatusValue == 22 {
                CBToast.showToastAction(message: "密码不正确")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断退出登录状态
    /// type: 弹出*登录页面*的方式
    class func judgeExit( _ type: EntryType) {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        let rootVc = UIViewController.currentViewController()
        
        let exitVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        exitVM.loginExit {
            let exitStatusValue = exitVM.exitStatusValue
            
            // value: 0-成功
            if exitStatusValue == 0 {
                Defaults.removeAll()
                Defaults[.isLogin] = false
                //CBToast.showToastAction(message: "退出成功")
                
                if type == .present {
                    rootVc?.present(loginVC, animated: true)
                } else if type == .push {
                    rootVc?.navigationController?.pushViewController(loginVC, animated: true)
                } else {
                    print("进入*登录页*")
                }
            } else {
                CBToast.showToastAction(message: "退出失败")
            }
            
        }
    }
    
    /// 上传头像
    /// type: 弹出*登录页面*的方式
    class func uploadHeadImage( _ pickedImage: UIImage) {
        let rootVc = UIViewController.currentViewController()
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        // value: 0-成功，4-token已失效，请重新登录
        infoVM.updateHeadImage(pickedImage) {
            let updateStatusValue = infoVM.updateStatusValue
            
            if updateStatusValue == 0 {
                CBToast.showToastAction(message: "更新成功")
                //请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.normal, .no)
            } else if updateStatusValue == 4 {
                rootVc?.dismiss(animated: true, completion: nil)
            }else {
                CBToast.showToastAction(message: "未知错误")
                rootVc?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
