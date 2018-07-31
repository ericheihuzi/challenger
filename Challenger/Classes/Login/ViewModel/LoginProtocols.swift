//
//  LoginProtocols.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/30.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import RxSwift
import RxCocoa

enum LoginValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(message: String)
}

enum LoginState {
    case loginedUp(loginedUp: Bool)
}

protocol LoginAPI {
    func phoneNumAvailable(_ phoneNum: String) -> Observable<Bool>
    func login(_ phoneNum: String, password: String) -> Observable<Bool>
}

protocol LoginValidationService {
    func validatePhoneNum(_ phoneNum: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> ValidationResult
}

extension LoginValidationResult {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

