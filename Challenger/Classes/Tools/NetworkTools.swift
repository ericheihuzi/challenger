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
        
        // 1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON { (response) in
            
            // 3.获取结果
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
    
    
    class func uploadImage2(URLString : String, pickedImage : UIImage, parameters : [String : Any]?, finishedCallback :  @escaping (_ result : Any) -> ()) {
        // 将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        //let parametersq: Parameters = ["token" : "8"]
        
        //上传图片
        //        if (fileManager.fileExists(atPath: filePath)) {
        //            //取得NSURL
        //            let imageURL = URL(fileURLWithPath: filePath)
        
        //            Alamofire.upload(multipartFormData: { (formData) in
        //                formData.append(imageData!, withName: "fileupload", fileName: "pickedimage", mimeType: "image/jpg")
        //            }, with: URLString, HTTPMethod.post) { (encodingResult) in
        //                switch encodingResult {
        //                case .success(let upload, _, _):
        //                    upload.responseJSON { response in
        //                        print("response = \(response)")
        //                        let result = response.result
        //                        if result.isSuccess {
        //                            success(response.value)
        //                        }
        //                    }
        //                case .failure(let encodingError):
        //                    failture(encodingError)
        //                }
        //
        //            }
        
        /*
         Alamofire.upload(data: { (formData) in
         // "fname" 这里是服务器对应好的字段
         formData.append(imageData as Data, withName: "fname", fileName: fileName, mimeType:"application/zip")
         
         //拼接参数
         for (key, value) in parametersq {
         let v = value as! String
         formData.append(v.data(using: String.Encoding.utf8)!, withName: key)
         }
         // usingThreshold 指的是传入文件大小最大值
         }, to: URLString, method: HTTPMethod.post, headers: nil).responseJSON { (response) in
         */
        // 3.获取结果
        //                guard let result = response.result.value else {
        //                    //print(response.result.error!)
        //                    let errorText = "似乎已断开与互联网的连接"
        //                    CBToast.showToastAction(message: errorText as NSString)
        //                    return
        //                }
        //
        //                // 4.将结果回调出去
        //                finishedCallback(result)
        //            }
        //        }
    }
    
    
    class func uploadImage(URLString : String, parameters: [String : Any], pickedImage : UIImage, finishedCallback :  @escaping (_ result : Any) -> ()) {
        //let parameters:NSMutableDictionary = NSMutableDictionary()
        
        //parameters.setValue(token, forKey:"token")
        
        //let url = URL(fileURLWithPath: filePath)
        print("------------------------------")
        print(pickedImage)
        print("------------------------------")
        // 将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        let imageData = UIImageJPEGRepresentation(pickedImage, 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let str = dateFormatter.string(from:NSDate() as Date)
        
        Alamofire.upload(
            multipartFormData: { (multipartFormData) in
                multipartFormData.append(imageData!, withName: "picImage", fileName: "\(str).jpg", mimeType: "image/jpeg")
                
                //遍历字典
                for (key, value) in parameters {
                    let str: String = value as! String
                    let data: Data = str.data(using: String.Encoding.utf8)!
                    multipartFormData.append(data, withName: key)
                }
        },
            to: URLString, method: HTTPMethod.post) { (result) in
                switch result {
                case .success(let upload,_, _):
                    upload.responseJSON(completionHandler: { (response) in
                        print(response.result.description)
                        guard let result = response.result.value else {
                            print(response.result.error!)
                            //let errorText = "似乎已断开与互联网的连接"
                            //CBToast.showToastAction(message: errorText as NSString)
                            return
                        }
                        // 4.将结果回调出去
                        finishedCallback(result)
                    })
                    
                case .failure:
                    print("网络异常")
                }
                
        }
    }
    
}
