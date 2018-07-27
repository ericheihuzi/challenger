//
//  DefaultImplementations.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift

import struct Foundation.CharacterSet
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.NSRange
import class Foundation.URLSession
import func Foundation.arc4random

class GitHubDefaultValidationService: GitHubValidationService {
    let API: GitHubAPI
    
    static let sharedValidationService = GitHubDefaultValidationService(API: GitHubDefaultAPI.sharedAPI)
    
    init (API: GitHubAPI) {
        self.API = API
    }
    
    // validation
    
    let minPasswordCount = 6
    
    func validatePhoneNum(_ phoneNum: String) -> Observable<ValidationResult> {
        let phoneCharacters = phoneNum.count
        if phoneCharacters > 11 {
            return .just(.failed(message: "请输入正确的手机号"))
        } else if phoneCharacters > 0 && phoneCharacters < 11 {
            return .just(.failed(message: ""))
        }
        
        if phoneNum.isEmpty {
            return .just(.empty)
        }
        
        // this obviously won't be
        if phoneNum.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(message: "phoneNum can only contain numbers or digits"))
        }
        
        let loadingValue = ValidationResult.validating
        
        return API
            .phoneNumAvailable(phoneNum)
            .map { available in
                if available {
                    //手机号可用
                    return .ok(message: "可以注册")
                }
                else {
                    return .failed(message: "该手机号已经被注册了")
                }
            }
            .startWith(loadingValue)
    }
    
    func validatePassword(_ password: String) -> ValidationResult {
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(message: "密码最少需要 \(minPasswordCount) 个字符")
        }
        
        return .ok(message: "密码可用")
    }
    
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult {
        if repeatedPassword.count == 0 {
            return .empty
        }
        
        if repeatedPassword == password {
            return .ok(message: "密码重复")
        }
        else {
            return .failed(message: "密码不同")
        }
    }
}


class GitHubDefaultAPI : GitHubAPI {
    
    let URLSession: Foundation.URLSession
    
    static let sharedAPI = GitHubDefaultAPI(
        URLSession: Foundation.URLSession.shared
    )
    
    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func phoneNumAvailable(_ phoneNum: String) -> Observable<Bool> {
        // this is ofc just mock, but good enough
        
        let url = URL(string: "https://github.com/\(phoneNum.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request)
            .map { pair in
                return pair.response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    
    func signup(_ phoneNum: String, password: String) -> Observable<Bool> {
        // this is also just a mock
        let signupResult = arc4random() % 5 == 0 ? false : true
        
        return Observable.just(signupResult)
            .delay(1.0, scheduler: MainScheduler.instance)
    }
    
    func login(_ phoneNum: String, password: String) -> Observable<Bool> {
        // this is also just a mock
        let loginResult = arc4random() % 5 == 0 ? false : true
        
        return Observable.just(loginResult)
            .delay(1.0, scheduler: MainScheduler.instance)
    }
}
