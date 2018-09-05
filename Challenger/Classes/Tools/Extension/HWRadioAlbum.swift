//
//  HWRadioAlbum.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/4.
//  Copyright © 2018年 黑胡子. All rights reserved.
//
/*
import UIKit

class HWRadioAlbum: NSObject, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    /// 选择图片的回调
    var selectedImageBlock : ((UIImage) -> ())?
    /// 显示提示框
    func showPromptBox() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let takePhotos = UIAlertAction(title: "拍照", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true, completion: nil)
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
                UIApplication.shared.keyWindow?.rootViewController?.present(picker, animated: true, completion: nil)
            } else {
                print("读取相册失败")
            }
        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        UIApplication.shared.keyWindow?.rootViewController?.present(actionSheet, animated: true, completion: nil)
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
        if self.selectedImageBlock != nil {
            self.selectedImageBlock!(pickedImage)
        }
        picker.dismiss(animated: true) {
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
*/
