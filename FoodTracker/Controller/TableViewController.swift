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

class TableViewController: UIViewController, NSFetchedResultsControllerDelegate{
    
    @IBOutlet weak var tableViewController: UITableView!
    
    var tableViewDataSource: TableViewDataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataServices.share.dataInCoreData()
        tableViewController.dataSource = tableViewDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(selectedEditButton(sender:)))
        navigationItem.leftBarButtonItem = editButton
        tableViewController.reloadData()
    }
    
    @objc func selectedEditButton(sender: UIBarButtonItem){
        
        navigationItem.leftBarButtonItem?.title = tableViewController.isEditing == true ? "Edit" : "Done"
        self.tableViewController.isEditing = tableViewController.isEditing == true ? false : true
    }
    
    @IBAction func unwindToMealViewController(sender: UIStoryboardSegue){
        
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "ShowDetail":
            let vc = segue.destination as? MealViewController
            if let index = tableViewController.indexPathForSelectedRow?.row {
                vc?.meal = DataServices.share.meals[index]
            }
        case "AddMeal":
            os_log("Do nothing...!")
        default:
            return
        }
    }
    
}
