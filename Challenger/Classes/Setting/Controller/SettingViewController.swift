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
        if isLogin {
            loginOutConfirm()
        } else {
            PageJump.JumpToLogin(.present)
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
        let alert = UIAlertController(style: .actionSheet, title: nil, message: nil)
        alert.addAction(title: "取消", style: .cancel)
        alert.addAction(title: "退出登录", style: .destructive) { action in
            // 退出登录
            RequestJudgeState.judgeExit(.present)
            print("登录状态4：\(Defaults[.isLogin])")
        }
        alert.show()
    }
    
}
