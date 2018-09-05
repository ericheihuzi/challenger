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
}
