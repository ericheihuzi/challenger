//
//  AllChallengeViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/26.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit


class AllChallengeViewController: UITableViewController {
    
    @IBOutlet var tableview: UITableView!
    
    var listTeams: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let plistPath = Bundle.main.path(forResource: "team", ofType: "plist")
        //获取属性列表文件中的全部数据
        self.listTeams = NSArray(contentsOfFile: plistPath!)!
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
    }
    
    //MARK: --UITableViewDataSource 协议方法
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listTeams.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
        
        let row = (indexPath as NSIndexPath).row
        
        let rowDict = self.listTeams[row] as! NSDictionary
        cell.textLabel?.text = rowDict["name"] as? String
        
        let imagePath = String(format: "%@.png", rowDict["image"] as! String)
        cell.imageView?.image = UIImage(named: imagePath)
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

