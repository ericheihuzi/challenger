//
//  GithubSignupViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
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
class GithubSignupViewModel {
    // outputs {
    
    //
    let validatedPhoneNum: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    // Is signup button enabled
    let signupEnabled: Driver<Bool>
    
    // Has user signed in
    let signedIn: Driver<Bool>
    
    // Is signing process in progress
    let signingIn: Driver<Bool>
    
    // }
    
    init(
        input: (
        phoneNum: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<()>
        ),
        dependency: (
        API: GitHubAPI,
        validationService: GitHubValidationService,
        wireframe: Wireframe
        )
        ) {
        let API = dependency.API
        let validationService = dependency.validationService
        //let wireframe = dependency.wireframe
        
        /**
         Notice how no subscribe call is being made.
         Everything is just a definition.
         
         Pure transformation of input sequences to output sequences.
         
         When using `Driver`, underlying observable sequence elements are shared because
         driver automagically adds "shareReplay(1)" under the hood.
         
         .observeOn(MainScheduler.instance)
         .catchErrorJustReturn(.Failed(message: "Error contacting server"))
         
         ... are squashed into single `.asDriver(onErrorJustReturn: .Failed(message: "Error contacting server"))`
         */
        
        validatedPhoneNum = input.phoneNum
            .flatMapLatest { phoneNum in
                return validationService.validatePhoneNum(phoneNum)
                    .asDriver(onErrorJustReturn: .failed(message: "服务器连接出错"))
        }
        
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
        }
        
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
        
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asDriver()
        
        let phoneNumAndPassword = Driver.combineLatest(input.phoneNum, input.password) { (phoneNum: $0, password: $1) }
        
        signedIn = input.loginTaps.withLatestFrom(phoneNumAndPassword)
            .flatMapLatest { pair in
                
                print("注册成功!!!")
                Defaults[.isLogin] = true
                Defaults[.userID] = "1234"
                Defaults[.phone] = "18600823208"
                Defaults[.nickName] = "黑胡子"
                Defaults[.userHeadImageURL] = "headimage_heihuzi"
                print("登录状态9：\(Defaults[.isLogin])")
                
                return API.signup(pair.phoneNum, password: pair.password)
                    .trackActivity(signingIn)
                    .asDriver(onErrorJustReturn: false)
            }
            /*
            .flatMapLatest { loggedIn -> Driver<Bool> in
                let message = loggedIn ? "Mock: Signed in to GitHub." : "Mock: Sign in to GitHub failed"
                return wireframe.promptFor(message, cancelAction: "OK", actions: [])
                    // propagate original value
                    .map { _ in
                        loggedIn
                    }
                    .asDriver(onErrorJustReturn: false)
        }
        */
        
        signupEnabled = Driver.combineLatest(
            validatedPhoneNum,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn
        )   { phoneNum, password, repeatPassword, signingIn in
            phoneNum.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
            }
            .distinctUntilChanged()
    }
}
