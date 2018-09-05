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

class LoginViewModel {
    
    let validatedAccount: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    
    // Is login button enabled（启用登录按钮）
    let loginEnabled: Driver<Bool>
    
    // Has user logined in（用户登录）
    let loginedIn: Driver<Bool>
    
    // Is logining process in progress（正在进行登录过程吗？）
    let loginingIn: Driver<Bool>
    
    init (
        input: (
        account: Driver<String>,
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
        
        validatedAccount = input.account
            .map { account in
                return validationService.validateAccount(account)
        }
        
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
        }
        
        let loginingIn = ActivityIndicator()
        self.loginingIn = loginingIn.asDriver()
        
        let accountAndPassword = Driver.combineLatest(input.account, input.password) { (account: $0, password: $1) }
        
        loginedIn = input.loginTaps.withLatestFrom(accountAndPassword)
            .flatMapLatest { pair in
                return API.login(pair.account, pair.password)
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
            validatedAccount,
            validatedPassword,
            loginingIn
        )   { account, password, loginingIn in
            account.isValid &&
                password.isValid &&
                !loginingIn
            }
            .distinctUntilChanged()
    }
}
