//
//  GameBigTableViewCell.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/16.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBigTableViewCell: UITableViewCell {
    
    //控件属性
    @IBOutlet var CellView : UIView!
    @IBOutlet var gameCover: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    @IBOutlet var gameUnlockType: UIButton!
    @IBOutlet var levelTitle: UILabel!
    @IBOutlet var gameRanking: UILabel!
    @IBOutlet var levelBGView: UIView!
    
    //定义模型属性
    var GameBigCellModel : TodayFreeGameModel? {
        didSet {
            //设置基本信息
            gameTitle.text = GameBigCellModel?.gameTitle
            CellView.backgroundColor = UIColorTemplates.colorFromString((GameBigCellModel?.gameColor)!)
            gameUnlockType.setTitle(GameBigCellModel?.gameUnlockType, for: .normal)
            levelTitle.text = GameBigCellModel?.levelTitle
            gameRanking.text = "\(GameBigCellModel?.gameRanking ?? 0)"
            
            //设置图片
            let gameCoverURL = URL(string: GameBigCellModel?.gameCover ?? "")
            gameCover.kf.setImage(with: gameCoverURL, placeholder: UIImage(named: "second"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        gameUnlockType.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        levelBGView.layer.cornerRadius = 8.0
        if #available(iOS 11.0, *) {
            levelBGView.layer.maskedCorners = [CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
    }
    
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
}
