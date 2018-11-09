//
//  Theme.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/12.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    // MARK:- 主题色
    static var MainColor : UIColor = #colorLiteral(red: 0.6, green: 0, blue: 1, alpha: 1)
        //UIColor(red: 153.0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1)
    
    // MARK:- 文本颜色 - 黑白
    static var TextColor_Black : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    static var TextColor_DeepDarkGray : UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    //UIColor(red: 65.0/255.0, green: 70.0/255.0, blue: 77.0/255.0, alpha: 1)
    static var TextColor_DarkGray : UIColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1)
    static var TextColor_White : UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    
    // MARK:- 文本颜色 - 彩色
    static var TextColor_Blue : UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    //UIColor(red: 61.0/255.0, green: 172.0/255.0, blue: 247.0/255.0, alpha: 1)
    static var TextColor_Purple : UIColor = #colorLiteral(red: 0.6, green: 0, blue: 1, alpha: 1)
    //UIColor(red: 153.0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1)
    static var TextColor_Green : UIColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    //UIColor(red: 87.0/255.0, green: 159.0/255.0, blue: 43.0/255.0, alpha: 1)
    static var TextColor_Orange : UIColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
    //UIColor(red: 239.0/255.0, green: 89.0/255.0, blue: 49.0/255.0, alpha: 1)
    static var TextColor_Magenta : UIColor = #colorLiteral(red: 1, green: 0, blue: 1, alpha: 1)
    //UIColor(red: 255.0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1)
    static var TextColor_Crimson : UIColor = #colorLiteral(red: 0.862745098, green: 0.07843137255, blue: 0.2352941176, alpha: 1)
    //UIColor(red: 220.0/255.0, green: 20.0/255.0, blue: 60.0/255.0, alpha: 1)
    static var TextColor_red : UIColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    //UIColor(red: 255.0/255.0, green: 38.0/255.0, blue: 0/255.0, alpha: 1)
    
    // 排名
    static var TextColor_ranking_1 : UIColor = #colorLiteral(red: 1, green: 0.8107591998, blue: 0, alpha: 1)
    static var TextColor_ranking_2 : UIColor = #colorLiteral(red: 0.3368865114, green: 0.469123055, blue: 0.5994854134, alpha: 1)
    static var TextColor_ranking_3 : UIColor = #colorLiteral(red: 0.9372549057, green: 0.4985923073, blue: 0.2447614781, alpha: 1)
    static var TextColor_ranking_4 : UIColor = #colorLiteral(red: 0.5862921909, green: 0.5862921909, blue: 0.5862921909, alpha: 1)
    
    // MARK:- 背景颜色 - 黑白
    static var BGColor_Black : UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    static var BGColor_DarkGray : UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    //UIColor(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1)
    static var BGColor_MidGray : UIColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    //UIColor(red: 153.0/255.0, green: 153.0/255.0, blue: 153.0/255.0, alpha: 1)
    static var BGColor_LightGray : UIColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    //UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1)
    static var BGColor_HighLightGray : UIColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1)
        //UIColor(red: 220.0/255.0, green: 220.0/255.0, blue: 220.0/255.0, alpha: 1)
    static var BGColor_White : UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    
    // MARK:- 背景颜色 - 彩色
    static var BGColor_Purple : UIColor = #colorLiteral(red: 0.6, green: 0, blue: 1, alpha: 1)
        //UIColor(red: 153.0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1)
    static var BGColor_DeepDarkPurple : UIColor = #colorLiteral(red: 0.2392156863, green: 0.168627451, blue: 0.3019607843, alpha: 1)
        //UIColor(red: 61.0/255.0, green: 43.0/255.0, blue: 77.0/255.0, alpha: 1)
    static var BGColor_RedOrange : UIColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //UIColor(red: 236.0/255.0, green: 60.0/255.0, blue: 26.0/255.0, alpha: 1)
    
    // MARK:- 背景颜色 - 游戏主题色
    static var BGColor_Reasoning : UIColor = #colorLiteral(red: 0.7764705882, green: 0.262745098, blue: 0.9843137255, alpha: 1)
    static var BGColor_Calculation : UIColor = #colorLiteral(red: 0.04705882353, green: 0.8274509804, blue: 0.09411764706, alpha: 1)
    static var BGColor_Inspection : UIColor = #colorLiteral(red: 1, green: 0.4705882353, blue: 0, alpha: 1)
    static var BGColor_Memory : UIColor = #colorLiteral(red: 0.3450980392, green: 0.337254902, blue: 0.8392156863, alpha: 1)
    static var BGColor_Space : UIColor = #colorLiteral(red: 0.1137254902, green: 0.3921568627, blue: 0.9411764706, alpha: 1)
    static var BGColor_Create : UIColor = #colorLiteral(red: 1, green: 0.1647058824, blue: 0.4078431373, alpha: 1)
    
}
