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
    @IBOutlet var phoneNumOutlet: HoshiTextField!
    @IBOutlet var phoneNumValidationOutlet: UILabel!
    
    @IBOutlet var passwordOutlet: HoshiTextField!
    @IBOutlet var passwordValidationOutlet: UILabel!
    
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var loginingOutlet: UIActivityIndicatorView!
    
    @IBOutlet var forgetPasswordOutlet: UILabel!
    
    // MARK: 懒加载属性
    fileprivate lazy var ruserChallengeVM : UserChallengeViewModel = UserChallengeViewModel()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入登录页")
        print("登录状态2-2：\(Defaults[.isLogin])")
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        let viewModel = LoginViewModel(
            input: (
                phoneNum: phoneNumOutlet.rx.text.orEmpty.asDriver(),
                password: passwordOutlet.rx.text.orEmpty.asDriver(),
                loginTaps: loginOutlet.rx.tap.asSignal()
            ),
            dependency: (
                API: LoginDefaultAPI.sharedAPI,
                validationService: LoginDefaultValidationService.sharedValidationService,
                wireframe: DefaultWireframe.shared
            )
        )
        
        // bind results to  {
        viewModel.loginEnabled
            .drive(onNext: { [weak self] valid  in
                self?.loginOutlet.isEnabled = valid
                self?.loginOutlet.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedphoneNum
            .drive(phoneNumValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.validatedPassword
            .drive(passwordValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        viewModel.loginingIn
            .drive(loginingOutlet.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loginedIn
            .drive(onNext: { loginedIn in
                //print("登录成功")
                print("User logined in \(loginedIn)")
                // 获取数据
                self.loadData()
                // 关闭登录页
                self.dismiss(animated: true, completion: nil)
                CBToast.showToastAction(message: "登录成功")
            })
            .disposed(by: disposeBag)
        //}
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
        
        //进入页面时就弹出键盘，但是提示文字消失了
        //phoneNumOutlet.becomeFirstResponder()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func close(_ sender: Any) -> Void {
        print("关闭登录页")
        self.dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
}

extension LoginTableViewController {
    private func loadData() {
        loadUserChallenge()
        loadUserAccount()
    }
    
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
    
    // MARK: - 获取用户账户信息，并存到UserDefaults中
    private func loadUserAccount() {
        let accountPlist = Bundle.main.path(forResource: "UserAccount", ofType: "plist")
        // 1.获取属性列表文件中的全部数据
        guard let accountDict = NSDictionary(contentsOfFile: accountPlist!)! as? [String : Any] else {return}
        // 用户ID
        Defaults[.userID] = accountDict["userID"] as! Int
        // 手机号
        Defaults[.userPhoneNum] = accountDict["userPhoneNum"] as? String
        // 密码
        Defaults[.userPassword] = accountDict["userPassword"] as? String
        // 昵称
        Defaults[.userNickName] = accountDict["userNickName"] as? String
        // 头像URL
        Defaults[.userHeadImageURL] = accountDict["userHeadImageURL"] as? String
        // 性别
        Defaults[.userSex] = accountDict["userSex"] as? String
    }
}
