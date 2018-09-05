//
//  SignUpValidationService.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import SwiftyUserDefaults

import struct Foundation.CharacterSet
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.NSRange
import class Foundation.URLSession
import func Foundation.arc4random

class SignUpDefaultValidationService: SignUpValidationService {
    let API: SignUpAPI
    
    static let sharedValidationService = SignUpDefaultValidationService(API: SignUpDefaultAPI.sharedAPI)
    
    init (API: SignUpAPI) {
        self.API = API
    }
    
    let minPasswordCount = 6
    
    func validateAccount(_ account: String) -> ValidationResult {
        let accountCharacters = account.count
        if accountCharacters > 20 {
            return .failed(message: "账号不能超过20个字符")
        } else if accountCharacters > 0 && accountCharacters < 10 {
            return .failed(message: "账号不能少于10个字符")
        }
        
        if account.isEmpty {
            return .empty
        }
        
        // this obviously won't be
        if account.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .failed(message: "账号只能包含字母和数字")
        }
        
        //账号可用
        return .ok(message: "")
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码最少需要 \(minPasswordCount) 个字符")
        }
        //密码可用
        return .ok(message: "")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            // 密码重复
            return .ok(message: "输入正确")
        }
        else {
            return .failed(message: "两次输入的密码不相同")
        }
    }
}


class SignUpDefaultAPI : SignUpAPI {
    
    let URLSession: Foundation.URLSession
    
    static let sharedAPI = SignUpDefaultAPI(
        URLSession: Foundation.URLSession.shared
    )
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    /*
    func accountAvailable(_ account: String) -> Observable<Bool> {
        // this is ofc just mock, but good enough
        
        let url = URL(string: "https://github.com/\(phoneNum.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request)
            .map { pair in
                return pair.response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    */
    
    func signup(_ account: String, password: String) -> Observable<Bool> {
        print("---------------------------------------")
        print("account:\(account),password:\(password)")
        print("---------------------------------------")
        
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserRegister)", parameters: ["account" : account, "password" : password ]) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print(resultDict)
            
            // 获取登录状态
            guard let status = resultDict["status"] as? Int else { return }
            print(status)
            //将登录状态值存入userDefaults
            Defaults[.loginStatus] = status
            self.signupStatus(status)
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            CBToast.showToastAction(message: message as NSString)
            print(message)
            
            // 获取data:accessToken,userID并转为字典
            guard let dataDict = resultDict["data"] as? [String : Any] else { return }
            print(dataDict)
            
            //将data存入userDefaults
            Defaults[.userID] = dataDict["userID"] as? String         // 用户ID
            Defaults[.token] = dataDict["accessToken"] as? String     // token
        }
        
        // this is also just a mock
        let signupResult = arc4random() % 5 == 0 ? false : true
        
        return Observable.just(signupResult)
            .delay(1.0, scheduler: MainScheduler.instance)
    }
    
    func signupStatus(_ status: Int) {
        if status == 0 {
            Defaults[.isLogin] = true
        } else {
            Defaults[.isLogin] = false
        }
    }
}
