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
    @IBOutlet var PhoneNum: UILabel!
    @IBOutlet var AccountEditGate: UITableViewCell!
    @IBOutlet var LoginOutLabel: UILabel!
    
    var isLogin = Defaults[.isLogin]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showLoginSegue" {
            Defaults.removeAll()
            Defaults[.isLogin] = false
            
            /*
            let controller = segue.destination as! LoginViewController
            controller.loginState { (login) in
                print(login)
                self.isLogin = login
                self.judgeIsLogin()
            }
            */
        }
        
        print("登录状态4：\(Defaults[.isLogin])")
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("进入设置页")
        
        print("登录状态5：\(Defaults[.isLogin])")
        
        judgeIsLogin()
        
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
    
}

// MARK:- 设置UI界面
extension SettingViewController {
    private func judgeIsLogin() {
        if isLogin {
            // 设置已登录状态的UI
            LoginOutLabel.text = "退出登录"
            // 加载已登录用户的信息
            //print("用户ID：\(Defaults[.userID])")
            NickName.text = Defaults[.nickName]
            PhoneNum.text = Defaults[.phone]
            // 设置头像
            let headImageURL = URL(string: Defaults[.userHeadImageURL]!)
            self.HeadImage.kf.setImage(with: headImageURL, placeholder: UIImage(named: ""))
            //HeadImage.image = UIImage(named: Defaults[.userHeadImageURL]!)
            // 开启编辑页面跳转
            AccountEditGate.isUserInteractionEnabled = true
        } else {
            // 设置未登录状态的UI
            LoginOutLabel.text = "立即登录"
            NickName.text = "请登录"
            PhoneNum.text = ""
            HeadImage.image = UIImage(named: "")
            // 禁用编辑页面跳转
            AccountEditGate.isUserInteractionEnabled = false
        }
    }
}
