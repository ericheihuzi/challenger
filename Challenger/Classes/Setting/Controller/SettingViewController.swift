//
//  SettingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit
import SwiftyUserDefaults

class SettingViewController: UITableViewController {
    @IBOutlet var HeadImage: UIImageView!
    @IBOutlet var NickName: UILabel!
    @IBOutlet var Account: UILabel!
    @IBOutlet var AccountEditGate: UITableViewCell!
    @IBOutlet var LoginOutLabel: UILabel!
    
    var isLogin = Defaults[.isLogin]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入*设置页*")
        
        print("登录状态5：\(Defaults[.isLogin])")
        
        //judgeIsLogin()
        
        HeadImage.layer.borderColor = Theme.BGColor_HighLightGray.cgColor
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("登录状态8：\(Defaults[.isLogin])")
        self.isLogin = Defaults[.isLogin]
        self.judgeIsLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginOrExit(_ sender: Any) {
        let loginSB = UIStoryboard(name: "Login", bundle:nil)
        let loginVC = loginSB.instantiateViewController(withIdentifier: "LoginNavigationController") as! BashNavigationController
        
        if isLogin {
            loginOutConfirm()
        } else {
            self.present(loginVC, animated: true)
        }
    }
    
}

extension SettingViewController {
    // MARK: - 设置UI界面
    private func judgeIsLogin() {
        if isLogin {
            // 设置已登录状态的UI
            LoginOutLabel.text = "退出登录"
            // 加载已登录用户的信息
            NickName.text = Defaults[.nickName]
            Account.text = Defaults[.account]
            
            // 设置头像
            //拼接头像路径
            let headPath = "\(RequestHome)\(RequestUserHeadImage)"
            let headImageURL = URL(string: headPath + Defaults[.picName]!)
            
            if Defaults[.sex] == 2 {
                self.HeadImage.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
            } else {
                self.HeadImage.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
            }
            
            //HeadImage.image = UIImage(contentsOfFile: Defaults[.picPath]!)
            
            // 开启编辑页面跳转
            AccountEditGate.isUserInteractionEnabled = true
        } else {
            // 设置未登录状态的UI
            LoginOutLabel.text = "立即登录"
            NickName.text = "请登录"
            Account.text = ""
            if Defaults[.sex] == 2 {
                HeadImage.image = UIImage(named: "default_image_female.png")
            } else {
                HeadImage.image = UIImage(named: "default_image_male.png")
            }
            
            // 禁用编辑页面跳转
            AccountEditGate.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - 退出登录确认
    private func loginOutConfirm() {
        //let title = NSLocalizedString("退出登录", comment: "")
        let cancelButtonTitle = NSLocalizedString("取消", comment: "")
        let loginOutButtonTitle = NSLocalizedString("退出登录", comment: "")
        
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        alertController.addAction(UIAlertAction(
            title: NSLocalizedString(cancelButtonTitle, comment: ""),
            style: .cancel
        ) { _ in })
        alertController.addAction(UIAlertAction(
            title: NSLocalizedString(loginOutButtonTitle, comment: ""),
            style: .destructive
        ) { _ in
            // 退出登录
            RequestJudgeState.judgeExit(.present)
            print("登录状态4：\(Defaults[.isLogin])")
        })
        self.present(alertController, animated: true, completion: nil)
    }
    
}
