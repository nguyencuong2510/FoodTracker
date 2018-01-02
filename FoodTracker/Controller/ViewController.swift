//
//  ViewController.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/27/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import CoreData
import UIKit
import os.log

class ViewController: UIViewController, NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var tableViewController: UITableView!
    var tableViewDataSource: TableViewDataSource = TableViewDataSource()
    var tableViewDelegate: TableViewDelegate = TableViewDelegate()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.dataSource = tableViewDataSource
        tableViewController.delegate = tableViewDelegate
        
        if let savess = ServiceData.share.loadMeal(){
            ServiceData.share.meals += savess
        }else{
            ServiceData.share.loadSampleMeals()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(selectedEditButton(sender:)))
        navigationItem.leftBarButtonItem = editButton
    }
    
    @objc func selectedEditButton(sender: UIBarButtonItem){
        navigationItem.leftBarButtonItem?.title = tableViewController.isEditing == true ? "Edit" : "Done"
        self.tableViewController.isEditing = tableViewController.isEditing == true ? false : true
    }
    
    @IBAction func unwindToMealViewController(sender: UIStoryboardSegue){
        if let meal = ServiceData.share.meal {
            if let selectedIndexPath = tableViewController.indexPathForSelectedRow{
                ServiceData.share.meals[selectedIndexPath.row] = meal
                tableViewController.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let indexPath = IndexPath(row: ServiceData.share.meals.count, section: 0)
                ServiceData.share.meals.append(meal)
                tableViewController.insertRows(at: [indexPath], with: .automatic)
            }
            ServiceData.share.saveMeals()
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "AddMeal":
            ServiceData.share.meal = nil
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            os_log("ShowDetail a meal.", log: OSLog.default, type: .debug)
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier ?? "")")
        }
    }
    
}
