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
    
    var activityIndicator:UIActivityIndicatorView!
    
    // MARK: 懒加载属性
    fileprivate lazy var loginVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
    
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginRequest(_ sender: Any) {
        
        let account = accountOutlet.text!
        let password = passwordOutlet.text!
        loginVM.login(account, password) { (status) in
            if status == 0 {
                CBToast.showToastAction(message: "登录成功")
                Defaults[.account] = account
                
                // 请求userInfo
                RequestJudgeState.judgeLoadUserInfo(.present, .yes){
                    // 请求challengeInfo
                    RequestJudgeState.judgeLoadChallengeInfo(.present){}
                }
                
            } else if status == 22 {
                CBToast.showToastAction(message: "密码错误")
            } else if status == 21 {
                CBToast.showToastAction(message: "用户不存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
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
    
    private func loadingIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: kScreenW, height: kScreenH)
        self.view.addSubview(activityIndicator)
        
        //进度条开始转动
        activityIndicator.startAnimating()
        
        DispatchAfter(after: 20) {
            //进度条停止转动
            self.activityIndicator.stopAnimating()
        }
    }
    
}
