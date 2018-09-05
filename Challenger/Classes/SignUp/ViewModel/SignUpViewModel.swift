//
//  SignUpViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyUserDefaults

class SignUpViewModel {
    
    let validatedAccount: Driver<ValidationResult>
    let validatedPassword: Driver<ValidationResult>
    let validatedPasswordRepeated: Driver<ValidationResult>
    
    // Is signup button enabled
    let signupEnabled: Driver<Bool>
    
    // Has user signed in
    let signedIn: Driver<Bool>
    
    // Is signing process in progress
    let signingIn: Driver<Bool>
    
    init(
        input: (
        account: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        loginTaps: Signal<()>
        ),
        dependency: (
        API: SignUpAPI,
        validationService: SignUpValidationService,
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
        
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
        
        let signingIn = ActivityIndicator()
        self.signingIn = signingIn.asDriver()
        
        let accountAndPassword = Driver.combineLatest(input.account, input.password) { (account: $0, password: $1) }
        
        signedIn = input.loginTaps.withLatestFrom(accountAndPassword)
            .flatMapLatest { pair in
                return API.signup(pair.account, password: pair.password)
                    .trackActivity(signingIn)
                    .asDriver(onErrorJustReturn: false)
            }
        
        signupEnabled = Driver.combineLatest(
            validatedAccount,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn
        )   { account, password, repeatPassword, signingIn in
            account.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
                !signingIn
            }
            .distinctUntilChanged()
    }
}
