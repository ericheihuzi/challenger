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
    
    init(
        input: (
        account: Driver<String>,
        password: Driver<String>,
        repeatedPassword: Driver<String>,
        validationService: SignUpValidationService
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
        
        validatedPasswordRepeated = Driver.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
        
        signupEnabled = Driver.combineLatest(
            validatedAccount,
            validatedPassword,
            validatedPasswordRepeated
        )   { account, password, repeatedPassword in
            account.isValid &&
                password.isValid &&
                repeatedPassword.isValid
            }
            .distinctUntilChanged()
    }
}
