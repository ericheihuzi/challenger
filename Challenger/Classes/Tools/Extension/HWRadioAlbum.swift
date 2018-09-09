//
//  HWRadioAlbum.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class HWRadioAlbum: NSObject, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    /// 是否直接上传头像
    var isUpload: Bool = false
    
    /// 选择图片的回调
    var selectedImageBlock : ((UIImage) -> ())?
    /// 显示提示框
    func showPromptBox() {
        let rootVc = UIViewController.currentViewController()
        let actionSheet = UIAlertController(title: "设置头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let takePhotos = UIAlertAction(title: "拍照", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                rootVc?.present(picker, animated: true, completion: nil)
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
                rootVc?.present(picker, animated: true, completion: nil)
            } else {
                print("读取相册失败")
            }
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        rootVc?.present(actionSheet, animated: true, completion: nil)
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
        let cropedImage = (info[UIImagePickerControllerEditedImage] as! UIImage).fixOrientation()
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
        if self.selectedImageBlock != nil {
            self.selectedImageBlock!(cropedImage)
        }
        
        // 图片控制器退出
        picker.dismiss(animated: true) {
            // 上传图片
            if self.isUpload {
                RequestJudgeState.uploadHeadImage(.present, cropedImage) { (status) in
                    if status == 0 {
                        print("头像设置成功")
                        CBToast.showToastAction(message: "头像设置成功")
                    } else {
                        print("头像设置失败")
                        CBToast.showToastAction(message: "头像设置失败，请重新设置")
                    }
                }
            } else {
                print("无需现在上传")
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
