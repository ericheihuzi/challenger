//
//  GameLevelViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/8/1.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import UIKit

private let LevelCell = "Cell"

class GameLevelViewController: UIViewController {
    
    @IBOutlet var BackgroundImage: UIImageView!
    @IBOutlet var LevelCollectionView: UICollectionView!
    
    var levelBackgroundColor: String?
    var LevelBackgroundImage: String?
    var LevelCellColor: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColorTemplates.colorFromString(levelBackgroundColor!)
        self.BackgroundImage.image = UIImage(named: LevelBackgroundImage!)
        
        self.LevelCollectionView.register(UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LevelCell)

        // Do any additional setup after loading the view.
    }
    
    // MARK: - 动态设置状态栏风格
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: UICollectionViewDataSource
extension GameLevelViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 56
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LevelCell, for: indexPath)
        cell.layer.cornerRadius = 8
        //cell.backgroundColor = UIColorTemplates.colorFromString(LevelCellColor!)
        // Configure the cell
        
        return cell
    }
}
