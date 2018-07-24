//
//  SettingViewController.swift
//  Challenger
//
//  Created by 黑胡子 on 2018/6/27.
//  Copyright © 2018年 黑胡子. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UITableViewController {
    
    /// Our data source is an array of city names, populated from Cities.json.
    //let dataSource = CitiesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.dataSource = dataSource
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pushSeque" {
            // This segue is pushing a detailed view controller.
            if let indexPath = self.tableView.indexPathForSelectedRow {
                segue.destination.title = dataSource.city(index: indexPath.row)
            }
            if #available(iOS 11.0, *) {
                // We choose not to have a large title for the destination view controller.
                segue.destination.navigationItem.largeTitleDisplayMode = .never
            }
        } else {
            // This segue is popping us back up the navigation stack.
        }
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
