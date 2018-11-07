//
//  SignUPTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/31.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class SignUpTableViewController: UITableViewController {
    // 控件属性
    @IBOutlet weak var accountOutlet: UITextField!
    @IBOutlet weak var accountValidationOutlet: UILabel!
    
    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var passwordValidationOutlet: UILabel!
    
    @IBOutlet weak var repeatedPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var signupOutlet: UIButton!
    
    // MARK: 懒加载属性
    fileprivate lazy var registerVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
    
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("进入注册页")
        print("登录状态2-3：\(Defaults[.isLogin])")
        
        // 加载UI设置
        setupUI()
        // 加载验证配置
        setupValidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerRequest(_ sender: Any) {
        let account = accountOutlet.text!
        let password = passwordOutlet.text!
        
        registerVM.register(account, password) { (status) in
            if status == 0 {
                CBToast.showToastAction(message: "注册成功")
                Defaults[.account] = account
                
                // 请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.push, .yes) {
                    // 请求challengeInfo
                    RequestJudgeState.judgeLoadChallengeInfo(.present) {}
                }
                
            } else if status == 1 {
                CBToast.showToastAction(message: "注册失败")
            } else if status == 20 {
                CBToast.showToastAction(message: "用户已存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
    }

}


extension SignUpTableViewController {
    // MARK: - 设置UI
    private func setupUI() {
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    // MARK: - 配置验证
    private func setupValidate() {
        let viewModel = SignUpViewModel(
            input: (
                account: accountOutlet.rx.text.orEmpty.asDriver(),
                password: passwordOutlet.rx.text.orEmpty.asDriver(),
                repeatedPassword: repeatedPasswordOutlet.rx.text.orEmpty.asDriver(),
                validationService: SignUpDefaultValidationService()
            )
        )
        
        viewModel.signupEnabled
            .drive(onNext: { [weak self] valid  in
                self?.signupOutlet.isEnabled = valid
                self?.signupOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedAccount
            .drive(accountValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPasswordRepeated
            .drive(repeatedPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
    
}
