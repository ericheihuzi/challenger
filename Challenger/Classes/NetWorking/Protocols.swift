//
//  Protocols.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa

enum ValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

//enum SignUpState {
//    case signedUp(signedUp: Bool)
//}

//protocol SignUpAPI {
//    //func accountAvailable(_ account: String) -> Observable<Bool>
//    func signup(_ account: String, password: String) -> Observable<Bool>
//}

protocol UserInfoValidationService {
    func validateNickName(_ nickName: String) -> ValidationResult
}

protocol SignUpValidationService {
    func validateAccount(_ account: String) -> ValidationResult //Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, _ repeatedPassword: String) -> ValidationResult
}

protocol LoginValidationService {
    func validateAccount(_ account: String) -> ValidationResult
    func validatePassword(_ password: String) -> ValidationResult
}

protocol ChangePasswordValidationService {
    func validateOldPassword(_ oldPassword: String) -> ValidationResult
    func validateNewPassword(_ newPassword: String) -> ValidationResult
    func validateRepeatedNewPassword(_ newPassword: String, _ repeatedNewPassword: String) -> ValidationResult
}

extension ValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

