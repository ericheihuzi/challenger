//
//  LoginViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyUserDefaults

/**
 This is example where view model is mutable. Some consider this to be MVVM, some consider this to be Presenter,
 or some other name.
 In the end, it doesn't matter.
 
 If you want to take a look at example using "immutable VMs", take a look at `TableViewWithEditingCommands` example.
 
 This uses Driver builder for sequences.
 
 Please note that there is no explicit state, outputs are defined using inputs and dependencies.
 Please note that there is no dispose bag, because no subscription is being made.
 */
class LoginViewModel {
    // outputs {
    
    let validatedphoneNum: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    
    // Is login button enabled
    let loginEnabled: Driver<Bool>
    
    // Has user logined in
    let loginedIn: Driver<Bool>
    
    // Is logining process in progress
    let loginingIn: Driver<Bool>
    
    // }
    
    init(
        input: (
        phoneNum: Driver<String>,
        password: Driver<String>,
        loginTaps: Signal<()>
        ),
        dependency: (
        API: LoginAPI,
        validationService: LoginValidationService,
        wireframe: Wireframe
        )
        ) {
        let API = dependency.API
        let validationService = dependency.validationService
        //let wireframe = dependency.wireframe
        
        validatedphoneNum = input.phoneNum
            .flatMapLatest { phoneNum in
                return validationService.validatePhoneNum(phoneNum)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器连接出错"))
        }
        
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
        }
        
        let loginingIn = ActivityIndicator()
        self.loginingIn = loginingIn.asDriver()
        
        let phoneNumAndPassword = Driver.combineLatest(input.phoneNum, input.password) { (phoneNum: $0, password: $1) }
        
        loginedIn = input.loginTaps.withLatestFrom(phoneNumAndPassword)
            .flatMapLatest { pair in
                
                print("登录成功!!!")
                Defaults[.isLogin] = true
                Defaults[.userID] = 1234
                Defaults[.userPhoneNum] = "18600823208"
                Defaults[.userNickName] = "黑胡子"
                Defaults[.userHeadImageURL] = "headimage_heihuzi"
                print("登录状态1：\(Defaults[.isLogin])")
                
                return API.login(pair.phoneNum, password: pair.password)
                    .trackActivity(loginingIn)
                    .asDriver(onErrorJustReturn: false)
            }
            
            /*
            .flatMapLatest { loggedIn -> Driver<Bool> in
                
                let message = loggedIn ? "Mock: logined in to GitHub." : "Mock: login in to GitHub failed"
                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
                    // propagate original value
                    .map { _ in
                        loggedIn
                    }
                    .asDriver(onErrorJustReturn: false)
            }
            */
        
        loginEnabled = Driver.combineLatest(
            validatedphoneNum,
            validatedPassword,
            loginingIn
        )   { phoneNum, password, loginingIn in
            phoneNum.isValid &&
                password.isValid &&
                !loginingIn
            }
            .distinctUntilChanged()
    }
}
