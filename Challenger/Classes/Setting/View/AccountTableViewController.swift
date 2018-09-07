//
//  AccountTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/24.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class AccountTableViewController: UITableViewController {
    let radioAlbum = HWRadioAlbum()
    @IBOutlet weak var HeadImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setHeadImage(_ sender: Any) {
        radioAlbum.showPromptBox()
    }

}

extension AccountTableViewController {
    private func setupUI() {
        self.navigationController?.navigationBar.tintColor = Theme.MainColor

        // 选择图片的回调
        weak var weakSelf = self // 弱引用
        radioAlbum.selectedImageBlock = { (image)in
            weakSelf!.HeadImageView.image = image
        }
        radioAlbum.isUpload = true //添加完成后直接上传至服务器
        
    }
}
