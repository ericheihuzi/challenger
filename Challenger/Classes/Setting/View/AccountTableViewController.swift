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
    @IBOutlet weak var NickNameUILabel: UILabel!
    @IBOutlet weak var BirthdayUILabel: UILabel!
    @IBOutlet weak var SexUILabel: UILabel!
    @IBOutlet weak var PhoneUILabel: UILabel!
    
    let nickNameAlert = UIAlertController(style: .actionSheet, title: "设置昵称", message: "昵称需要6~20个字哦")
    let birthdayAlert = UIAlertController(style: .actionSheet, title: "设置生日", message: nil)
    let sexAlert = UIAlertController(style: .actionSheet, title: "设置性别", message: nil)
    let phoneAlert = UIAlertController(style: .actionSheet, title: "设置手机号", message: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
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
        birthdayAlert.show()
    }
    // 设置性别
    @IBAction func setSex(_ sender: Any) {
        sexAlert.show()
    }
    // 设置手机号
    @IBAction func setPhone(_ sender: Any) {
        print("设置手机号")
    }
    // 修改密码
    @IBAction func setChange(_ sender: Any) {
        PageJump.JumpToChange(.push)
    }
    
}

extension AccountTableViewController {
    private func loadData() {
        // 加载头像
        let headPath = "\(RequestHome)\(RequestUserHeadImage)"
        let headImageURL = URL(string: headPath + Defaults[.picName]!)
        if Defaults[.sex] == 2 {
            self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_female.png"))
        } else {
            self.HeadImageView.kf.setImage(with: headImageURL, placeholder: UIImage(named: "default_image_male.png"))
        }
        
        // 加载昵称
        if Defaults[.nickName] == "" {
            self.NickNameUILabel.text = "未设置"
        } else {
            self.NickNameUILabel.text = Defaults[.nickName]
        }
        
        // 加载生日
        if Defaults[.birthday] == "" {
            self.BirthdayUILabel.text = "未设置"
        } else {
            self.BirthdayUILabel.text = Defaults[.birthday]
        }
        
        // 加载性别
        switch Defaults[.sex] {
        case 0:
            self.SexUILabel.text = "保密"
        case 1:
            self.SexUILabel.text = "男"
        case 2:
            self.SexUILabel.text = "女"
        default:
            self.SexUILabel.text = "保密"
        }
        
        // 加载手机号
        if Defaults[.phone] == "" {
            self.PhoneUILabel.text = "未设置"
        } else {
            self.PhoneUILabel.text = Defaults[.phone]
        }
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        // 选择图片的回调
        weak var weakSelf = self // 弱引用
        radioAlbum.selectedImageBlock = { (image) in
            weakSelf!.HeadImageView.image = image
        }
        radioAlbum.isUpload = true //添加完成后直接上传至服务器
        
        setNickNameAlert()
        setBirthdayAlert()
        setSexAlert()
    }
    
    private func setNickNameAlert() {
        var textInputCount: Int = 0
        var nickNameText: String = ""
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
                //Log("textField = \(textField.text ?? "")")
                textInputCount = textField.text!.count
                nickNameText = textField.text!
            }
        }
        
        nickNameAlert.addOneTextField(configuration: textField)
        
        nickNameAlert.addAction(title: "完成", style: .cancel) { _ in
            self.nickNameFinishButton(textInputCount, nickNameText)
        }
    }
    
    private func setBirthdayAlert() {
        var birthdayText: String = ""
        birthdayAlert.addDatePicker(mode: .date, date: Date(), minimumDate: nil, maximumDate: nil) { date in
            Log(date)
            
            let timeZone = NSTimeZone.system
            let formatter = DateFormatter()
            formatter.timeZone = timeZone
            formatter.dateFormat = "yyyy-MM-dd"
            birthdayText = formatter.string(from: date)
        }
        birthdayAlert.addAction(title: "完成", style: .cancel) { _ in
            self.birthdayFinishButton(birthdayText)
        }
    }
    
    private func setSexAlert() {
        var sexValue: Int = 0
        let frameSizes: [CGFloat] = (0...2).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [["保密", "男", "女"]] //frameSizes.map { Int($0).description }
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 1, row: frameSizes.index(of: 0) ?? 0)
        
        sexAlert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            /*
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    vc.preferredContentSize.height = frameSizes[index.row]
                }
            }
             */
            sexValue = index.row
        }
        sexAlert.addAction(title: "完成", style: .cancel) { _ in
            self.sexFinishButton(sexValue)
        }
    }
    
    private func nickNameFinishButton(_ count: Int, _ text: String) {
        if text != Defaults[.nickName] {
            if count >= 6 && count <= 20 {
                let infoDict: [String : Any] = [
                    "token" : Defaults[.token]!,
                    "nickName" : text
                ]
                
                /*
                // 更新用户信息 方式1
                let infoVM : UserInfoViewModel = UserInfoViewModel()
                infoVM.updateUserInfo(infoDict) { (status) in
                    print("修改用户信息status = \(status)")
                    if status == 0 {
                        CBToast.showToastAction(message: "昵称设置成功!")
                        self.NickNameUILabel.text = text
                        //请求userInfo
                        RequestJudgeState.judgeLoadUserInfo(.normal, .no)
                    } else if status == 4 {
                        CBToast.showToastAction(message: "更新失败，需重新登录!")
                        PageJump.JumpToLogin(.present)
                    } else {
                        CBToast.showToastAction(message: "未知错误")
                    }
                }
                */
                // 更新用户信息 方式2
                RequestJudgeState.judgeUpdateUserInfo(infoDict, .normal, .no) { (status) in
                    if status == 0 {
                        self.NickNameUILabel.text = text
                    }
                }
            } else if count > 20 || count < 6 {
                CBToast.showToastAction(message: "昵称需要6~20个字哦!")
            }
        } else {
            CBToast.showToastAction(message: "您填写的昵称和原来的昵称相同啦!")
        }
    }
    
    private func birthdayFinishButton(_ date: String) {
        if date != Defaults[.birthday] && date != "" {
            let birthdayDict: [String : Any] = [
                "token" : Defaults[.token]!,
                "birthday" : date
            ]
            // 更新用户信息 方式2
            RequestJudgeState.judgeUpdateUserInfo(birthdayDict, .normal, .no) { (status) in
                if status == 0 {
                    self.BirthdayUILabel.text = date
                }
            }
        } else if date == "" {
            CBToast.showToastAction(message: "请选择您的生日")
        } else {
            CBToast.showToastAction(message: "您选择的生日和原来的生日相同啦!")
        }
    }
    
    private func sexFinishButton(_ sex: Int) {
        if sex != Defaults[.sex] {
            let infoDict: [String : Any] = [
                "token" : Defaults[.token]!,
                "sex" : sex
            ]
            // 更新用户信息 方式2
            RequestJudgeState.judgeUpdateUserInfo(infoDict, .normal, .no) { (status) in
                if status == 0 {
                    switch sex {
                    case 0:
                        self.SexUILabel.text = "保密"
                    case 1:
                        self.SexUILabel.text = "男"
                    case 2:
                        self.SexUILabel.text = "女"
                    default:
                        self.SexUILabel.text = "保密"
                    }
                }
            }
        } else {
            CBToast.showToastAction(message: "您选择的性别和原来的性别相同啦!")
        }
    }
    
}
