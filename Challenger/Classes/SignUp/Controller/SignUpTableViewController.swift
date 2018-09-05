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
    
    var disposeBag = DisposeBag()
    
    // MARK: - 懒加载属性
    fileprivate lazy var registerVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
    fileprivate lazy var userChallengeVM : UserChallengeViewModel = UserChallengeViewModel()
    fileprivate lazy var infoVM : UserInfoViewModel = UserInfoViewModel()

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
        // 请求数据
        loadData()
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
    
    // MARK: - 请求数据
    fileprivate func loadData() {
        self.registerVM.account = self.accountOutlet.text
        self.registerVM.password = self.passwordOutlet.text
        // 注册状态：0:成功，20:用户已存在，1:失败，条件不足，无法注册
        registerVM.register {
            let registerStatusValue = self.registerVM.registerStatusValue
            
            if registerStatusValue == 0 {
                CBToast.showToastAction(message: "注册成功")
                Defaults[.account] = self.registerVM.account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                //请求userInfo
                self.infoVM.loadUserInfo {
                    let infoStatusValue = self.infoVM.loadStatusValue
                    print("infoStatusValue = \(infoStatusValue ?? 2)")
                    self.judgeLoadInfo(infoStatusValue ?? 2)
                }
            } else if registerStatusValue == 1 {
                CBToast.showToastAction(message: "注册失败")
            } else if registerStatusValue == 20 {
                CBToast.showToastAction(message: "用户已存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
        
    }
    
    private func judgeLoadInfo(_ value: Int) {
        let infoSB = UIStoryboard(name: "AddUserInfo", bundle:nil)
        let infoVC = infoSB.instantiateViewController(withIdentifier: "AddUserInfoViewController") as! AddUserInfoViewController
        
        // 获取用户信息状态：0:成功，1:用信息为空
        if value == 0 {
            CBToast.showToastAction(message: "获取个人信息成功")
            // 关闭注册页
            print("----> 即将关闭*注册页*")
            self.dismiss(animated: true, completion: nil)
            print("----> 已关闭*注册页*")
        } else if value == 1 {
            //CBToast.showToastAction(message: "用户信息为空")
            print("----> 即将进入*完善个人信息页*")
            // 弹出完善用户信息页
            navigationController?.pushViewController(infoVC, animated: true)
            print("----> 已进入*完善个人信息页*")
        } else {
            CBToast.showToastAction(message: "未知错误")
        }
    }
    
}

