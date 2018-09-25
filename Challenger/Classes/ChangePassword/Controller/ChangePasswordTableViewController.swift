//
//  ChangePasswordTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/7.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class ChangePasswordTableViewController: UITableViewController {
    // 控件属性
    @IBOutlet weak var oldPasswordOutlet: UITextField!
    @IBOutlet weak var oldPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var newPasswordOutlet: UITextField!
    @IBOutlet weak var newPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var repeatedNewPasswordOutlet: UITextField!
    @IBOutlet weak var repeatedNewPasswordValidationOutlet: UILabel!
    
    @IBOutlet weak var changeOutlet: UIButton!
    
    var disposeBag = DisposeBag()
    var account = Defaults[.account]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入修改密码页")
        
        print("登录状态2-3：\(Defaults[.isLogin])")
        
        // 加载UI设置
        setupUI()
        // 加载验证配置
        setupValidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func changePasswordRequest(_ sender: Any) {
        let account = Defaults[.account]
        // 修改密码
        RequestJudgeState.judgeChangePassword(account!, oldPasswordOutlet.text!, newPasswordOutlet.text!)
    }
    
}


extension ChangePasswordTableViewController {
    // MARK: - 设置UI
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
    }
    
    // MARK: - 配置验证
    private func setupValidate() {
        let viewModel = ChangePasswordViewModel(
            input: (
                oldPassword: oldPasswordOutlet.rx.text.orEmpty.asDriver(),
                newPassword: newPasswordOutlet.rx.text.orEmpty.asDriver(),
                repeatedNewPassword: repeatedNewPasswordOutlet.rx.text.orEmpty.asDriver(),
                validationService: ChangePasswordDefaultValidationService()
            )
        )
        
        viewModel.changeEnabled
            .drive(onNext: { [weak self] valid  in
                self?.changeOutlet.isEnabled = valid
                self?.changeOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedOldPassword
            .drive(oldPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedNewPassword
            .drive(newPasswordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)

        viewModel.validatedRepeatedNewPassword
            .drive(repeatedNewPasswordValidationOutlet.rx.validationResult)
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

