//
//  TableViewDataSource.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/27/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServiceData.share.meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MealTableViewCell else { fatalError("error") }
        cell.nameLabel.text = ServiceData.share.meals[indexPath.row].name
        cell.photoImageView.image = ServiceData.share.meals[indexPath.row].photo
        cell.ratingControl.rating = ServiceData.share.meals[indexPath.row].rating
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            ServiceData.share.meals.remove(at: indexPath.row)
            ServiceData.share.saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
}
