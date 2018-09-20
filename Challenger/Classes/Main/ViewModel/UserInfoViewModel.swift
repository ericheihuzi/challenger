//
//  UserInfoViewModel.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/9/5.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class UserInfoViewModel {
    lazy var infos : [UserInfoModel] = [UserInfoModel]()
    
    var userInfoLoad : UserInfoModel? {
        didSet {
            Defaults[.phone] = userInfoLoad?.phone
            Defaults[.location] = userInfoLoad?.location
            Defaults[.nickName] = userInfoLoad?.nickName
            Defaults[.picName] = userInfoLoad?.picName
            Defaults[.sex] = userInfoLoad!.sex
            Defaults[.birthday] = userInfoLoad?.birthday
            Defaults[.age] = userInfoLoad!.age
        }
    }
    
}

extension UserInfoViewModel {
    // 获取用户信息
    // Method: .get
    // Parameters: token: string
    func loadUserInfo(finishedCallback : @escaping (_ status: Int) -> ()) {
        NetworkTools.requestData(.get, URLString: "\(RequestHome)\(RequestUserInfoPath)" + "token=" + Defaults[.token]!) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            //print("获取用户信息结果 = \(resultDict)")
            
            // 获取status: 0-成功，1-用户信息为空，4-token已失效，请重新登录
            guard let status = resultDict["status"] as? Int else { return }
            print("获取用户信息状态 = \(status)")
            
            // 获取状态提示语
            guard let message = resultDict["message"] as? String else { return }
            print("获取用户信息提示 = \(message)")
            
            if status == 0 {
                guard let accountDict = resultDict["data"] as? [String : Any] else { return }
                print("获取用户信息数据 = \(accountDict)")
                
                // 将数据存入模型
                let infoData = UserInfoModel(dict: accountDict)
                // 将模型存入userDefaults
                self.userInfoLoad = infoData
                
                Defaults[.isLogin] = true
            } else {
                Defaults[.isLogin] = false
            }
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 获取头像文件并保存至本地
    // Method: .get
    func loadHeadImage(_ headName: String) {
        
        // 拼接头像URL
        let headPath = "\(RequestHome)\(RequestUserHeadImage)"
        let headImageURL = headPath + headName
        
        // 获取头像文件
        NetworkTools.requestData(.get, URLString: headImageURL) { (imageData) in
            print("即将获取头像成功")
            guard let image = imageData as? UIImage else {
                print("获取头像文件失败")
                return
            }
            // 将选择的图片保存到Document目录下
            let fileManager = FileManager.default
            let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                               .userDomainMask, true)[0] as String
            let filePath = "\(rootPath)/headimage.jpg"
            let imageData = UIImageJPEGRepresentation(image, 1.0)
            fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
            Defaults[.picPath] = filePath
            print("本地保存头像成功")
            print("filePath = \(filePath)")
        }
    }
    
    // 更新用户信息
    // Method: .post
    // Parameters: token:string//age:int//sex:int//nickName:string//phone:string
    // birthday:string//location:string//picName:data(file)
    func updateUserInfo(_ userInfoUpdate : [String : Any], finishedCallback : @escaping (_ status : Int) -> ()) {
        print("要提交的用户信息 = \(userInfoUpdate)")
        NetworkTools.requestData(.post, URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: userInfoUpdate) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("更新用户信息结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            //print("更新状态 = \(status)")
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("更新提示 = \(message)")
            
            //完成回调
            finishedCallback(status)
        }
    }
    
    // 上传头像
    // Method: .post
    // Parameters: picName:data(file)
    func updateHeadImage(_ pickedImage: UIImage, finishedCallback : @escaping (_ status: Int) -> ()) {
        let parameters: [String : Any] = [
            "token" : Defaults[.token]!
        ]
        NetworkTools.uploadImage(URLString: "\(RequestHome)\(RequestUserInfoUpdate)", parameters: parameters, pickedImage: pickedImage) { (result) in
            // 将获取的数据转为字典
            guard let resultDict = result as? [String : Any] else { return }
            print("上传头像结果 = \(resultDict)")
            
            // 获取status
            guard let status = resultDict["status"] as? Int else { return }
            //print("上传状态 = \(status)")
            
            // 获取状态提示语
            //guard let message = resultDict["message"] as? String else { return }
            //print("上传提示 = \(message)")
            //完成回调
            finishedCallback(status)
        }
    }
    
}
