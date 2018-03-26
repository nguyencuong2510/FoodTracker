//
//  ServiceData.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/27/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit
import os.log
import CoreData

class DataServices {
    static let share = DataServices()
    
    //MARK: tableVC
    var meals = [Meals]()
    
    func saveContext(name: String, image: UIImage, rating: Int, meal: Meals?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        if let meal = meal {
            meal.name = name
            meal.image = image
            meal.rating = Int32(rating)
        }else {
            let managedContext = appDelegate.persistentContainer.viewContext
            let context = Meals(context: managedContext)
            context.name = name
            context.image = image
            context.rating = Int32(rating)
            meals.append(context)
        }
        appDelegate.saveContext()
    }
    
    func deleteData(indexPath: IndexPath) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(meals[indexPath.row])
        meals.remove(at: indexPath.row)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func dataInCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
    
        do {
            meals = try managedContext.fetch(Meals.fetchRequest()) as! [Meals]
        } catch {
            fatalError("\(error)")
        }
    }
    

}
