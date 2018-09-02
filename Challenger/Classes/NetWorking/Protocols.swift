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

enum SignupState {
    case signedUp(signedUp: Bool)
}

protocol GitHubAPI {
    func phoneNumAvailable(_ phoneNum: String) -> Observable<Bool>
    func signup(_ phoneNum: String, password: String) -> Observable<Bool>
}

protocol GitHubValidationService {
    func validatePhoneNum(_ phoneNum: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> ValidationResult
}

enum LoginState {
    case loginedUp(loginedUp: Bool)
}

protocol LoginAPI {
    //func accountAvailable(_ account: String) -> Observable<Bool>
    func login(_ account: String, _ password: String) -> Observable<Bool>
}

protocol LoginValidationService {
    func validateaccount(_ account: String) -> ValidationResult
    func validatePassword(_ password: String) -> ValidationResult
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

