//
//  ChangePasswordViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyUserDefaults

class ChangePasswordViewModel {
    
    let validatedOldPassword: Driver<ValidationResult>
    let validatedNewPassword: Driver<ValidationResult>
    let validatedRepeatedNewPassword: Driver<ValidationResult>
    
    // Is change button enabled
    let changeEnabled: Driver<Bool>
    
    init(
        input: (
        oldPassword: Driver<String>,
        newPassword: Driver<String>,
        repeatedNewPassword: Driver<String>,
        validationService: ChangePasswordValidationService
        )
        ) {
        
        let validationService = input.validationService
        
        validatedOldPassword = input.oldPassword
            .map { oldPassword in
                return validationService.validateOldPassword(oldPassword)
        }
        
        validatedNewPassword = input.newPassword
            .map { newPassword in
                return validationService.validateNewPassword(newPassword)
        }
        
        validatedRepeatedNewPassword = Driver.combineLatest(input.newPassword, input.repeatedNewPassword, resultSelector: validationService.validateRepeatedNewPassword)
        
        changeEnabled = Driver.combineLatest(
            validatedOldPassword,
            validatedNewPassword,
            validatedRepeatedNewPassword
        )   { oldPassword, newPassword, repeatedNewPassword in
                oldPassword.isValid &&
                newPassword.isValid &&
                repeatedNewPassword.isValid
            }
            .distinctUntilChanged()
    }
}

