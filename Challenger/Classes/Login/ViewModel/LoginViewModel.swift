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
    
    let loginEnabled: Driver<Bool>
    
    init (
        input: (
        account: Driver<String>,
        password: Driver<String>,
        validationService: LoginValidationService
        )
        ) {

        let validationService = input.validationService
        
        validatedAccount = input.account
            .map { account in
                return validationService.validateAccount(account)
        }
        
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
        }
        
        loginEnabled = Driver.combineLatest(
            validatedAccount,
            validatedPassword
        )   { account, password in
            account.isValid &&
                password.isValid
            }
            .distinctUntilChanged()
    }
}
