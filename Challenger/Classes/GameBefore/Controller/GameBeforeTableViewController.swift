//
//  GameBeforeTableViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/7/17.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

class GameBeforeTableViewController: UITableViewController {
    @IBOutlet var ContentView: UITableView!
    @IBOutlet var ButtonBGView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 动态设置状态栏风格,透明导航栏
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    func gradientBackground() -> CAGradientLayer {
        // 定义渐变的颜色（从黄色渐变到橙色）
        let topColor = UIColor(red: 0xfe/255, green: 0xd3/255, blue: 0x2f/255, alpha: 1)
        let buttomColor = UIColor(red: 0xfc/255, green: 0x68/255, blue: 0x20/255, alpha: 1)
        let gradientColors = [topColor.cgColor, buttomColor.cgColor]
        
        // 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        // 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        // 设置渲染的起始结束位置（横向渐变）
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        gradientLayer.frame = self.view.bounds
        return gradientLayer
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK:- 设置UI界面
extension GameBeforeTableViewController {
    private func setupUI() {
        //设置导航栏
        setupNavigationBar()
        //设置背景
        setBackground()
    }
    private func setupNavigationBar() {
        //设置大标题样式
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        //设置标题
        self.navigationController?.navigationBar.topItem?.title = "快速分类"
    }
    private func setBackground() {
        
        //self.view.backgroundColor = UIColorTemplates.colorFromString("#ff339900")
        
        let gradientContent = gradientBackground("#ff33dd00", "#ff339900")
        //gradientContent.frame.size = ContentView.frame.size
        gradientContent.frame.size = CGSize(width: kScreenH, height: kScreenH)
        ContentView.layer.insertSublayer(gradientContent, at: 0)
        
        let gradientView = gradientBackground("#00339900", "#ff339900")
        //gradientView.frame.size = ButtonBGView.frame.size
        gradientView.frame.size = CGSize(width: kScreenH, height: 64)
        ButtonBGView.layer.insertSublayer(gradientView, at: 0)
    }
    
    private func gradientBackground(_ startColor: String, _ endColor: String) -> CAGradientLayer {
        // 定义渐变的颜色（从黄色渐变到橙色）
        let Color1 = UIColorTemplates.colorFromString(startColor)
        let Color2 = UIColorTemplates.colorFromString(endColor)
        let gradientColors = [Color1.cgColor, Color2.cgColor]
        
        // 定义每种颜色所在的位置
        //let gradientLocations:[NSNumber] = [0.0, 1.0]
        
        // 创建CAGradientLayer对象并设置参数
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        //gradientLayer.locations = gradientLocations
        
        // 设置渲染的起始结束位置
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        // 设置其CAGradientLayer对象的frame，并插入view的layer
        //        gradientLayer.frame = self.view.bounds
        return gradientLayer
    }
}

