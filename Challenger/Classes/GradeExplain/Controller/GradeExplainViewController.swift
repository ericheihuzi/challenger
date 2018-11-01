//
//  GradeExplainViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/10.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

// MARK:- 定义全局常量
private let GradeCell = "Cell"

class GradeExplainViewController: UIViewController {
    @IBOutlet var gradeTableView: UITableView!
    
    // MARK: 懒加载属性
    fileprivate lazy var gradeVM : ChallengeInfoViewModel = ChallengeInfoViewModel()
    
    //var Grade: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // 请求数据
        loadData()
        
        self.navigationController?.navigationBar.tintColor = Theme.MainColor
        
        gradeTableView.delegate = self
        gradeTableView.dataSource = self
        self.gradeTableView.register(UINib(nibName: "GradeTableViewCell", bundle: nil), forCellReuseIdentifier: GradeCell)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension GradeExplainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gradeVM.grade.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GradeCell, for: indexPath) as! GradeTableViewCell
        let gradeModel = gradeVM.grade[indexPath.row]
        cell.GradeCellModel = gradeModel
        
        let grade = gradeModel.grade
        let Grade = Defaults[.grade]
        if grade == Grade {
            cell.MyGradeView.isHidden = false
        } else {
            cell.MyGradeView.isHidden = true
        }
        
        return cell
    }
    
}

extension GradeExplainViewController {
    // MARK:- 网络数据请求
    fileprivate func loadData() {
        gradeVM.loadGradeList {
            self.gradeTableView.reloadData()
        }
    }
}
