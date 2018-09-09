//
//  AccountTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class AccountTableViewController: UITableViewController {
    let radioAlbum = HWRadioAlbum()
    @IBOutlet weak var HeadImageView: UIImageView!
    
    let nickNameAlert = UIAlertController(style: .actionSheet, title: "设置昵称", message: "昵称最少要6个字哦")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 设置头像
    @IBAction func setHeadImage(_ sender: Any) {
        radioAlbum.showPromptBox()
    }
    // 设置昵称
    @IBAction func setNickName(_ sender: Any) {
        nickNameAlert.show()
    }
    // 设置生日
    @IBAction func setBirthday(_ sender: Any) {
        print("设置生日")
    }
    // 设置性别
    @IBAction func setSex(_ sender: Any) {
        print("设置性别")
    }
    // 设置手机号
    @IBAction func setPhone(_ sender: Any) {
        print("设置手机号")
    }
    
}

extension AccountTableViewController {
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        // 设置头像
        //拼接头像路径
        let headPath = "\(RequestHome)\(RequestUserHeadImage)"
        let headImageURL = URL(string: headPath + Defaults[.picName]!)
        if Defaults[.sex] == 2 {
            self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
        } else {
            self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
        }
        
        // 选择图片的回调
        weak var weakSelf = self // 弱引用
        radioAlbum.selectedImageBlock = { (image)in
            weakSelf!.HeadImageView.image = image
        }
        radioAlbum.isUpload = true //添加完成后直接上传至服务器
        
        setNickNameAlert()
    }
    
    private func setNickNameAlert() {
        var textInputCount: Int = 0
        let textField: TextField.Config = { textField in
            textField.left(image: #imageLiteral(resourceName: "user"), color: .black)
            textField.leftViewPadding = 12
            textField.becomeFirstResponder()
            textField.borderWidth = 1
            textField.cornerRadius = 8
            textField.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
            textField.backgroundColor = nil
            textField.textColor = .black
            textField.placeholder = "请输入昵称"
            textField.keyboardAppearance = .default
            textField.keyboardType = .default
            //textField.isSecureTextEntry = true
            textField.returnKeyType = .done
            textField.action { textField in
                Log("textField = \(textField.text ?? "")")
                textInputCount = textField.text!.count
                print(textInputCount)
            }
        }
        
        nickNameAlert.addOneTextField(configuration: textField)
        nickNameAlert.addAction(title: "完成", style: .cancel) {(_) in
            self.nickNameFinishButton(textInputCount)
        }
    }
    
    
    private func nickNameFinishButton(_ count: Int) {
        if count >= 6 && count <= 20 {
            print("允许修改")
        } else {
            print("拒绝修改")
        }
    }
}
