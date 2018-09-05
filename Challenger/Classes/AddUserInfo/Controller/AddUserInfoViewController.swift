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

class AddUserInfoViewController: UIViewController {
    @IBOutlet var ClickHeadUIView: UIView!
    @IBOutlet var HeadImageView: UIImageView!
    @IBOutlet var NickNameTextField: UITextField!
    @IBOutlet var NickNameValidationOutlet: UILabel!
    @IBOutlet var SubmitButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        //添加头像阴影
        self.ClickHeadUIView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.ClickHeadUIView.layer.shadowOpacity = 0.5
        self.ClickHeadUIView.layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
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
        
//        viewModel.finishing
//            .drive(loginingOutlet.rx.isAnimating)
//            .disposed(by: disposeBag)
        
//        viewModel.finished
//            .drive(onNext: { finished in
//                print(finished)
//            })
//            .disposed(by: disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
        view.addGestureRecognizer(tapBackground)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func submit(_ sender: Any) -> Void {
        print("关闭信息页")
        self.dismiss(animated: true, completion: nil)
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
        print(pickedImage)
        print("\(info)")
        // 是否支持相册
        if UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypePhotoLibrary) { // 相册
        } else if (UIImagePickerController.isValidImagePickerType(type: UIImagePickerType.UIImagePickerTypeCamera)){ // 相机
            // 图片保存到相册
            UIImageWriteToSavedPhotosAlbum(pickedImage, self, Selector(("imageSave:error:contextInfo:")), nil)
        }
        
        if self.HeadImageView != nil {
            self.HeadImageView.image = pickedImage
        }
        picker.dismiss(animated: true) {
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

