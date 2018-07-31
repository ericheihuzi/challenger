//
//  LoginViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/30.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class LoginViewController: UIViewController {
    // 控件属性
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var phoneNumOutlet: HoshiTextField!
    @IBOutlet var phoneNumValidationOutlet: UILabel!
    
    @IBOutlet var passwordOutlet: HoshiTextField!
    @IBOutlet var passwordValidationOutlet: UILabel!
    
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var loginingOutlet: UIActivityIndicatorView!
    /*
    var disposeBag = DisposeBag()
    
    //typealias isLogin = (Bool)-> Void
    //var login:isLogin?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入登录页")
        print("登录状态2-1：\(Defaults[.isLogin])")
        
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.tintColor = Theme.MainColor
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
                API: GitHubDefaultAPI.sharedAPI,
                validationService: GitHubDefaultValidationService.sharedValidationService,
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
                print("登录成功")
                print("User logined in \(loginedIn)")
                self.dismiss(animated: true, completion: nil)
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
        // Dispose of any resources that can be recreated.
    }
    
    /**
     *  Unwind action that is targeted by the demos which present a modal view
     *  controller, to return to the main screen.
     */
    @IBAction func unwindToLoginViewController(_ sender: UIStoryboardSegue) {}
    
    /*
    func loginState(closure: @escaping isLogin){
        login = closure
    }
    */
    
    @IBAction func close(_ sender: Any) -> Void {
        print("关闭登录页")
        
        /*
        if login != nil {
            login!(Defaults[.isLogin])
        }
        */
        
        print("登录状态3：\(Defaults[.isLogin])")
        self.dismiss(animated: true, completion: nil)
    }
 */
}
