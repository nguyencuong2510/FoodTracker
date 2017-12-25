//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/25/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savess = loadMeal(){
            meals += savess
        }else{
            loadSampleMeals()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MealTableViewCell else {
            fatalError("Do not Identifier Cell!!")
        }

        cell.nameLabel.text = meals[indexPath.row].name
        cell.photoImageView.image = meals[indexPath.row].photo
        cell.ratingControl.rating = meals[indexPath.row].rating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    @IBAction func unwindToMealViewController(sender: UIStoryboardSegue){
        if let sourceViewController = sender.source as? MealViewController,let meal = sourceViewController.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }else{
                let indexPath = IndexPath(row: meals.count, section: 0)
                
                meals.append(meal)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            saveMeals()
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier ?? "" {
        case "AddMeal":
            os_log("Adding a new meal.", log: OSLog.default, type: .debug)
        case "ShowDetail":
            if let indexSelected = tableView.indexPathForSelectedRow{
                if let mealDetailViewController = segue.destination as? MealViewController {
                    let selectedMeal = meals[indexSelected.row]
                    mealDetailViewController.meal = selectedMeal
                }
            }
            
        default:
            fatalError("Unexpected Segue Identifier: \(segue.identifier ?? "")")
        }
    }
    
    
    private func loadSampleMeals(){
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal1")
        let photo3 = UIImage(named: "meal1")
        
        guard let meal1 = Meal(name: "Caprese Salad", photo: photo1, rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        meals += [meal1, meal2, meal3]
    }
    
    private func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: (Meal.ArchiveURL?.path)!)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMeal()-> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: (Meal.ArchiveURL?.path)!) as? [Meal]
    }

}
