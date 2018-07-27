//
//  WikipediaPage.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//
/*
import RxSwift

import class Foundation.NSDictionary

struct WikipediaPage {
    let title: String
    let text: String
    
    // tedious parsing part
    static func parseJSON(_ json: NSDictionary) throws -> WikipediaPage {
        guard
            let parse = json.value(forKey: "parse"),
            let title = (parse as AnyObject).value(forKey: "title") as? String,
            let t = (parse as AnyObject).value(forKey: "text"),
            let text = (t as AnyObject).value(forKey: "*") as? String else {
                throw apiError("Error parsing page content")
        }
        
        return WikipediaPage(title: title, text: text)
    }
}
*/
