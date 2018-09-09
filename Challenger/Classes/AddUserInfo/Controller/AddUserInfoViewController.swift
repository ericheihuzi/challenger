//
//  AddUserInfoViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults

class AddUserInfoViewController: UIViewController {
    let radioAlbum = HWRadioAlbum()
    
    // MARK: - 控件属性
    @IBOutlet var ClickHeadUIView: UIView!
    @IBOutlet weak var HeadImageView: UIImageView!
    @IBOutlet var NickNameTextField: UITextField!
    @IBOutlet var NickNameValidationOutlet: UILabel!
    @IBOutlet var SubmitButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var disposeBag = DisposeBag()
    
    var sex: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载UI设置
        setupUI()
        // 加载验证配置
        setupValidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segementedSex(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            // 男
            self.sex = 1
            print("男")
        case 1:
            // 女
            self.sex = 2
            print("女")
        case 2:
            // 未知
            self.sex = 0
            print("保密")
        default:
            break;
        }
    }
    
    @IBAction func submit(_ sender: Any) -> Void {
        // 网络请求
        updateInfo()
    }
    
    @IBAction func setHeadImage(_ sender: Any) {
        radioAlbum.showPromptBox()
    }

}

extension AddUserInfoViewController {
    // 提交用户信息
    private func updateInfo() {
        // Parameters: token:string//age:int//sex:int//nickName:string//phone:string
        // birthday:string//location:string//picImage:data(file)
        let infoDict: [String : Any] = [
            "token" : Defaults[.token]!,
            //"age" : 0,
            "sex" : sex,
            "nickName" : NickNameTextField.text ?? "",
            //"phone" : "未设置",
            //"birthday" : "未设置",
            //"location" : "未设置"
        ]
        
        // 更新用户信息
        RequestJudgeState.judgeUpdateUserInfo(.normal, infoDict)
        // 上传头像
        RequestJudgeState.uploadHeadImage(.pop, HeadImageView.image!) {(status) in
            if status == 0 {
                print("头像设置成功")
            } else {
                print("头像设置失败")
            }
        }
    }
    
    private func setupUI() {
        // 设置导航栏样式
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        // 添加头像阴影
        self.ClickHeadUIView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.ClickHeadUIView.layer.shadowOpacity = 0.5
        self.ClickHeadUIView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        // 选择图片的回调
        weak var weakSelf = self // 弱引用
        radioAlbum.selectedImageBlock = { (image)in
            weakSelf!.HeadImageView.image = image
        }
    }
    
    private func setupValidate() {
        let viewModel = AddUserInfoViewModel(
            input: (
                nickName: NickNameTextField.rx.text.orEmpty.asDriver(),
                validationService: AddUserInfoDefaultValidationService()
            )
        )
        
        viewModel.finishEnabled
            .drive(onNext: { [weak self] valid  in
                self?.SubmitButton.isEnabled = valid
                self?.SubmitButton.alpha = valid ? 1.0 : 0.5
            })
            .disposed(by: disposeBag)
        
        viewModel.validatedNickName
            .drive(NickNameValidationOutlet.rx.validationResult)
            .disposed(by: disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }
    
}

