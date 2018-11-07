//
//  NetworkTools.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/28.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTools {
    // 网络请求
    class func requestData(_ type : MethodType, URLString : String, parameters : [String : Any]? = nil, finishedCallback :  @escaping (_ result : Any) -> ()) {
        
        // 显示loading
        CBToast.showToastAction()
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 隐藏loading
            CBToast.hiddenToastAction()
            
            // 3.获取结果
            // 如果请求成功直接返回请求结果，如果请求失败，则返回resullt
            guard let result = response.result.value else {
                //print(response.result.error!)
                let errorText = "似乎已断开与互联网的连接"
                CBToast.showToastAction(message: errorText as NSString)
                return
            }
            
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
    
    // 上传图片
    class func uploadImage(URLString : String, parameters: [String : Any], pickedImage : UIImage, finishedCallback :  @escaping (_ result : Any) -> ()) {
        // 将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        let imageData = pickedImage.jpegData(compressionQuality: 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        // 生成图片名称
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let imageName = dateFormatter.string(from:NSDate() as Date)
        
        // 网络请求
        Alamofire.upload( multipartFormData: { (multipartFormData) in
            multipartFormData.append(imageData!, withName: "picImage", fileName: "\(imageName).jpg", mimeType: "image/jpeg")
            
            //遍历参数字典
            for (key, value) in parameters {
                let str: String = value as! String
                let data: Data = str.data(using: String.Encoding.utf8)!
                multipartFormData.append(data, withName: key)
            }
        }, to: URLString,
           method: HTTPMethod.post) { (uploadResult) in
            switch uploadResult {
            case .success(let upload,_, _):
                upload.responseJSON(completionHandler: { (response) in
                    print(response.result.description)
                    
                    guard let result = response.result.value else {
                        print(response.result.error!)
                        return
                    }
                    
                    // 将结果回调出去
                    finishedCallback(result)
                }
                )
                
            case .failure:
                print("似乎已断开与互联网的连接")
                CBToast.showToastAction(message: "似乎已断开与互联网的连接")
            }
        }
    }
    
}
