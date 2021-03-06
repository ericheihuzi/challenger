//
//  MineViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 44

@IBDesignable
class MineViewController: UIViewController {

    @IBAction func unwindToMineViewController(_ sender: UIStoryboardSegue) {}
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var abilityView: UIView!
    @IBOutlet weak var progressView: UIView!
    
    @IBAction func segementedChange(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            abilityView.isHidden = false
            progressView.isHidden = true
        case 1:
            abilityView.isHidden = true
            progressView.isHidden = false
        default:
            break;
        }
    }

    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        print("----------------------------------------")
        print(">>>>>>>>>>>>>>>>>> 进入我的")
        abilityView.isHidden = false
        progressView.isHidden = true
        
//        if #available(iOS 11.0, *) {
//            self.navigationController?.navigationBar.prefersLargeTitles = true
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
