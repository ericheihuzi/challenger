//
//  LoginTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class LoginTableViewController: UITableViewController {
    // MARK: - 控件属性
    @IBOutlet var accountOutlet: HoshiTextField!
    @IBOutlet var accountValidationOutlet: UILabel!
    
    @IBOutlet var passwordOutlet: HoshiTextField!
    @IBOutlet var passwordValidationOutlet: UILabel!
    
    @IBOutlet var loginOutlet: UIButton!
    
    //@IBOutlet var forgetPasswordOutlet: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入登录页")
        // 加载UI设置
        setupUI()
        // 加载验证配置
        setupValidate()
        
        // 进入页面时就弹出键盘，但是提示文字消失了
        //accountOutlet.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(_ sender: Any) -> Void {
        print("关闭登录页")
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginRequest(_ sender: Any) {
        // 登录
        RequestJudgeState.judgeLogin(accountOutlet.text!, passwordOutlet.text!)
    }
}

extension LoginTableViewController {
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
        let viewModel = LoginViewModel(
            input: (
                account: accountOutlet.rx.text.orEmpty.asDriver(),
                password: passwordOutlet.rx.text.orEmpty.asDriver(),
                validationService: LoginDefaultValidationService()
            )
        )
        
        viewModel.loginEnabled
            .drive(onNext: { [weak self] valid  in
                self?.loginOutlet.isEnabled = valid
                self?.loginOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedAccount
            .drive(accountValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validationResult)
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
