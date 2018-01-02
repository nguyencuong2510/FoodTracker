//
//  ServiceData.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/27/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import Foundation
import UIKit
import os.log

class ServiceData {
    static let share = ServiceData()
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    static let ArchiveURL = DocumentsDirectory?.appendingPathComponent("meals")
    //MARK: VC
    var meal: Meal?
    
    
    
    //MARK: tableVC
    var meals = [Meal]()
    
    func loadSampleMeals(){
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
    
    func saveMeals(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: (ServiceData.ArchiveURL?.path)!)
        if isSuccessfulSave {
            os_log("Meals successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save meals...", log: OSLog.default, type: .error)
        }
    }
    
    func loadMeal()-> [Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: (ServiceData.ArchiveURL?.path)!) as? [Meal]
    }

}
