//
//  AddUserInfoViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa
import SwiftyUserDefaults

class AddUserInfoViewModel {
    
    let validatedNickName: Driver<ValidationResult>
    let finishEnabled: Driver<Bool>
    
    init (
        input: (
        nickName: Driver<String>,
        validationService: UserInfoValidationService
        )
        ) {
        let validationService = input.validationService
        
        validatedNickName = input.nickName
            .map { nickName in
                return validationService.validateNickName(nickName)
        }
        
        finishEnabled = Driver.combineLatest(
            validatedNickName,
            validatedNickName
        )   { nickName, nickName2 in
            nickName.isValid &&
                nickName2.isValid
            }
            .distinctUntilChanged()
    }
}
