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
    case pop
}

enum DismissType {
    case yes
    case no
}

///value说明：
//请求成功 ok = 0
//请求失败 error = 1
//缺少参数 missesPara = 3
//Token已失效，请重新登录 token = 4
//未知失败 unknown = 10
//用户已存在 userExist = 20
//用户不存在 userNotExist = 21
//密码不正确 passwordError = 22

class RequestJudgeState {
    
    /// 判断loadUserInfo状态
    /// type: 弹出*完善个人信息页面*的方式
    /// dismiss: 是否关闭当前页面
    class func judgeLoadUserInfo(_ type: EntryType, _ dismiss: DismissType, finishedCallback : @escaping () -> ()) {
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        
        infoVM.loadUserInfo { (status) in
            if status == 0 {
                print("获取用户信息成功")
                
                switch dismiss {
                case .yes:
                    PageJump.BackToAny(.dismiss)
                case .no: break
                }
                
                //完成回调
                finishedCallback()
                
            } else if status == 1 {
                print("用户信息为空")
                // 若用户信息为空则弹出*完善个人信息页面*
                switch type {
                case .push:
                    PageJump.JumpToInfo(.push)
                case .present:
                    PageJump.JumpToInfo(.present)
                default: break
                }
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断loadChallengeInfo状态
    /// type: 弹出*登录页面*的方式
    class func judgeLoadChallengeInfo(_ type: EntryType, finishedCallback : @escaping () -> ()) {
        let challengeVM : ChallengeInfoViewModel = ChallengeInfoViewModel()
        
        challengeVM.loadChallengeInfo { (status) in
            if status == 0 {
                print("获取挑战信息成功")
                
                //完成回调
                finishedCallback()
            } else if status == 4 {
                print("Token已失效，请重新登录")
                switch type {
                case .present:
                    PageJump.JumpToLogin(.present)
                case .push:
                    PageJump.JumpToLogin(.push)
                case .pop:
                    PageJump.BackToAny(.pop)
                default: break
                }
            } else if status == 1 {
                print("挑战信息为空")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断updateUserInfo状态
    /// type: 弹出*登录页面*的方式
    class func judgeUpdateUserInfo(_ dict: [String : Any], _ type: EntryType, _ dismiss: DismissType, finishedCallback : @escaping () -> ()) {
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        infoVM.updateUserInfo(dict) { (status) in
            if status == 0 {
                CBToast.showToastAction(message: "更新成功")
                //请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.normal, dismiss) {}
                //完成回调
                finishedCallback()
                
            } else if status == 4 {
                CBToast.showToastAction(message: "更新失败，请重新登录")
                switch type {
                case .present:
                    PageJump.JumpToLogin(.present)
                case .push:
                    PageJump.JumpToLogin(.push)
                case .pop:
                    PageJump.BackToAny(.pop)
                default: break
                }
            } else {
                CBToast.showToastAction(message: "未知错误")
                //PageJump.BackToAny(.dismiss)
            }
            
        }
    }
    
    /// 判断token是否失效
    class func judgeTokenAccess(finishedCallback : @escaping () -> ()) {
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        let dict: [String : Any] = [
            "token" : Defaults[.token]!
        ]
        infoVM.updateUserInfo(dict) { (status) in
            if status == 0 {
                //完成回调
                finishedCallback()
                
            } else {
                print("token已失效")
                Defaults.removeAll()
                Defaults[.isLogin] = false
                PageJump.JumpToLogin(.present)
            }
            
        }
    }
    
    /// 上传头像
    /// type: 弹出*登录页面*的方式
    class func uploadHeadImage( _ type: EntryType, _ pickedImage: UIImage, finishedCallback : @escaping () -> ()) {
        let infoVM : UserInfoViewModel = UserInfoViewModel()
        
        infoVM.updateHeadImage(pickedImage) { (status) in
            if status == 0 {
                print("头像设置成功")
                CBToast.showToastAction(message: "头像设置成功")
                //完成回调
                finishedCallback()
                
            } else if status == 4 {
                switch type {
                case .present:
                    PageJump.JumpToLogin(.present)
                case .push:
                    PageJump.JumpToLogin(.push)
                case .pop:
                    PageJump.BackToAny(.pop)
                default: break
                }
            } else {
                print("头像设置失败")
                CBToast.showToastAction(message: "头像设置失败，请重新设置")
                PageJump.BackToAny(.dismiss)
            }
        }
    }
    
    /*
    /// 判断登录状态
    class func judgeLogin(_ account: String, _ password: String, finishedCallback : @escaping () -> ()) {
        let LoginVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        LoginVM.login(account, password) { (status) in
            if status == 0 {
                CBToast.showToastAction(message: "登录成功")
                Defaults[.account] = account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                //完成回调
                finishedCallback()
                
                //请求userInfo
                //RequestJudgeState.judgeLoadUserInfo(.push, .yes){}
                // 请求challengeInfo
                //RequestJudgeState.judgeLoadChallengeInfo(.present){}
                
            } else if status == 22 {
                CBToast.showToastAction(message: "密码错误")
            } else if status == 21 {
                CBToast.showToastAction(message: "用户不存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    */
    
    /*
    /// 判断注册状态
    class func judgeRegister(_ account: String, _ password: String) {
        let registerVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        registerVM.register(account, password) { (status) in
            if status == 0 {
                CBToast.showToastAction(message: "注册成功")
                Defaults[.account] = account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                // 请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.push, .yes){}
                // 请求challengeInfo
                RequestJudgeState.judgeLoadChallengeInfo(.present){}
                
            } else if status == 1 {
                CBToast.showToastAction(message: "注册失败")
            } else if status == 20 {
                CBToast.showToastAction(message: "用户已存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    */
    
    /// 判断修改密码状态
    class func judgeChangePassword(_ account: String, _ password: String, _ newPassword: String) {
        let changeVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        changeVM.changePassword(account,password,newPassword) { (status) in
            //print("修改密码status = \(status)")
            if status == 0 {
                CBToast.showToastAction(message: "修改成功")
                
                //返回上一页
                PageJump.BackToAny(.pop)
                
                //延迟2秒执行退出登录：如果不设置延迟，弹窗会很快就消失
                //DispatchAfter(after: 2) {
                    //退出登录
                    //RequestJudgeState.judgeExit(.present)
                //}
                
            } else if status == 22 {
                CBToast.showToastAction(message: "密码不正确")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }
    
    /// 判断退出登录状态
    /// type: 弹出*登录页面*的方式
    class func judgeExit() {
        let exitVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
        
        exitVM.loginExit { (status) in
            Defaults.removeAll()
            Defaults[.isLogin] = false
            
            PageJump.JumpToLogin(.present)
            
            if status == 0 {
                //CBToast.showToastAction(message: "退出成功")
            } else {
                CBToast.showToastAction(message: "服务器退出失败")
            }
            print("登录状态4：\(Defaults[.isLogin])")
        }
    }
    
    /// 判断获取游戏列表状态
    /// type: 弹出*登录页面*的方式
    class func judgeLoadGameList() {
        let gameVM : GameViewModel = GameViewModel()
        
        gameVM.loadGameList() {}
    }
    
}
