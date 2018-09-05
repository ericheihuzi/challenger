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
    // MARK: - 控件属性
    @IBOutlet var ClickHeadUIView: UIView!
    @IBOutlet var HeadImageView: UIImageView!
    @IBOutlet var NickNameTextField: UITextField!
    @IBOutlet var NickNameValidationOutlet: UILabel!
    @IBOutlet var SubmitButton: UIButton!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    // MARK: - 懒加载属性
    fileprivate lazy var infoVM : UserInfoViewModel = UserInfoViewModel()
    
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
        
        //print("关闭信息页")
        //self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func setHeadImage(_ sender: Any) {
        self.showPromptBox()
    }

}

extension AddUserInfoViewController: UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    /// 显示提示框
    func showPromptBox() {
        let actionSheet = UIAlertController(title: "设置头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let takePhotos = UIAlertAction(title: "拍照", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)
            } else {
                print("模拟器中无法打开照相机,请在真机中使用");
            }
        })
        let selectPhotos = UIAlertAction(title: "相册", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            // 是否支持相册
            if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypePhotoLibrary){
                let picker = UIImagePickerController()
                picker.sourceType = .photoLibrary
                picker.delegate = self
                picker.allowsEditing = true
                picker.setImagePickerStyle(bgroundColor: UIColor.white, titleColor: Theme.MainColor, buttonTitleColor: Theme.MainColor) // 修改导航栏
                self.present(picker, animated: true, completion: nil)
            } else {
                print("读取相册失败")
            }
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
    }
    /*
     指定用户选择的媒体类型 UIImagePickerControllerMediaType
     原始图片 UIImagePickerControllerOriginalImage
     修改后的图片 UIImagePickerControllerEditedImage
     裁剪尺寸 UIImagePickerControllerCropRect
     媒体的URL UIImagePickerControllerMediaURL
     原件的URL UIImagePickerControllerReferenceURL
     当数据来源是照相机的时候这个值才有效 UIImagePickerControllerMediaMetadata
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 获取选择的原图
        let pickedImage = (info[UIImagePickerControllerEditedImage] as! UIImage).fixOrientation()
        print("---------------------------------------")
        print(pickedImage)
        print("---------------------------------------")
        print("\(info)")
        print("---------------------------------------")
        // 是否支持相册
        if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypePhotoLibrary) { // 相册
        } else if (UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypeCamera)){ // 相机
            // 图片保存到相册
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, Selector(("imageSave:error:contextInfo:")), nil)
        }
        
        if self.HeadImageView.image != nil {
            self.HeadImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true) {
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
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
            //"location" : "未设置",
            "picName" : HeadImageView.image!
        ]
        
        self.infoVM.userInfoUpdate = infoDict
        //提交userInfo
        self.infoVM.updateUserInfo {
            // 更新用户信息状态：0:成功，4:token失效，需重新登录
            if self.infoVM.updateStatusValue == 0 {
                // 获取已提交的用户信息并存入userDefaults
                self.infoVM.loadUserInfo {
                    self.judgeLoadInfo(self.infoVM.loadStatusValue!)
                }
            } else if self.infoVM.updateStatusValue == 4 {
                CBToast.showToastAction(message: "token失效，需重新登录")
                self.dismiss(animated: true, completion: nil)
            } else {
                CBToast.showToastAction(message: "未知错误")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    private func judgeLoadInfo(_ loadStatusValue: Int) {
        // 获取用户信息状态：0:成功，1:用信息为空
        if loadStatusValue == 0 {
            CBToast.showToastAction(message: "获取个人信息成功")
            
            print("----> 即将关闭*个人信息页*")
            self.dismiss(animated: true, completion: nil)
            print("----> 已关闭*个人信息页*")
        } else if loadStatusValue == 1 {
            CBToast.showToastAction(message: "提交信息出错，请重新提交")
            
        } else {
            CBToast.showToastAction(message: "未知错误")
        }
    }
    
    private func judgeUpdateInfo(_ status: Int) {
        if status == 0 {
            CBToast.showToastAction(message: "提交成功")
        } else {
            CBToast.showToastAction(message: "提交失败，请检查您的网络并重新提交")
        }
    }
    
    private func setupUI() {
        //设置导航栏样式
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        //添加头像阴影
        self.ClickHeadUIView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.ClickHeadUIView.layer.shadowOpacity = 0.5
        self.ClickHeadUIView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
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

