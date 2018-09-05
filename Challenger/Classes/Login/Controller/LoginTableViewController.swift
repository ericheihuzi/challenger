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
    
    // MARK: - 懒加载属性
    fileprivate lazy var loginVM : LoginAndRegisterViewModel = LoginAndRegisterViewModel()
    fileprivate lazy var userChallengeVM : UserChallengeViewModel = UserChallengeViewModel()
    fileprivate lazy var infoVM : UserInfoViewModel = UserInfoViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入登录页")
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
        // 请求数据
        loadData()
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
    
    // MARK: - 请求数据
    fileprivate func loadData() {
        self.loginVM.account = self.accountOutlet.text
        self.loginVM.password = self.passwordOutlet.text
        // 登录状态：0:成功，22:密码错误，21:用户不存在
        loginVM.login {
            let loginStatusValue = self.loginVM.loginStatusValue
            
            if loginStatusValue == 0 {
                CBToast.showToastAction(message: "登录成功")
                Defaults[.account] = self.loginVM.account
                print("用户账号 = \(Defaults[.account] ?? "")")
                
                //请求userInfo
                self.infoVM.loadUserInfo {
                    let infoStatusValue = self.infoVM.loadStatusValue
                    print("infoStatusValue = \(infoStatusValue ?? 2)")
                    self.judgeLoadInfo(infoStatusValue ?? 2)
                }
                
            } else if loginStatusValue == 22 {
                CBToast.showToastAction(message: "密码错误")
            } else if loginStatusValue == 21 {
                CBToast.showToastAction(message: "用户不存在")
            } else {
                CBToast.showToastAction(message: "未知错误")
            }
        }
        
    }
    /*
    // MARK: - 获取用户挑战信息，并存到UserDefaults中
    private func loadUserChallenge() {
        let challengePlist = Bundle.main.path(forResource: "UserChallengeData", ofType: "plist")
        // 1.获取属性列表文件中的全部数据
        guard let challengeDict = NSDictionary(contentsOfFile: challengePlist!)! as? [String : Any] else {return}
        // 挑战次数
        Defaults[.challengeNum] = challengeDict["challengeNum"] as! Int
        // 排名变化
        Defaults[.rankingChange] = challengeDict["rankingChange"] as! Int
        // 世界排名
        Defaults[.userWorldRanking] = challengeDict["userWorldRanking"] as! Int
        // 综合分数
        Defaults[.userScore] = challengeDict["userScore"] as! Int
        // 段位
        Defaults[.userGrade] = challengeDict["userGrade"] as? String
        // 雷达脑力值
        Defaults[.userReasoningScore] = challengeDict["userReasoningScore"] as! Int
        Defaults[.userCalculationScore] = challengeDict["userCalculationScore"] as! Int
        Defaults[.userInspectionScore] = challengeDict["userInspectionScore"] as! Int
        Defaults[.userMemoryScore] = challengeDict["userMemoryScore"] as! Int
        Defaults[.userSpaceScore] = challengeDict["userSpaceScore"] as! Int
        Defaults[.userCreateScore] = challengeDict["userCreateScore"] as! Int
    }
    */
    private func judgeLoadInfo(_ value: Int) {
        let infoSB = UIStoryboard(name: "AddUserInfo", bundle:nil)
        let infoVC = infoSB.instantiateViewController(withIdentifier: "AddUserInfoViewController") as! AddUserInfoViewController
        
        // 获取用户信息状态：0:成功，1:用信息为空
        if value == 0 {
            CBToast.showToastAction(message: "获取个人信息成功")
            // 关闭登录页
            print("----> 即将关闭*登录页*")
            self.dismiss(animated: true, completion: nil)
            print("----> 已关闭*登录页*")
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
