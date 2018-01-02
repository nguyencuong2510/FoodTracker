//
//  File.swift
//  FoodTracker
//
//  Created by cuong on 1/2/18.
//  Copyright © 2018 nguyencuong. All rights reserved.
//

import UIKit
class TableViewDelegate: NSObject, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ServiceData.share.meal = ServiceData.share.meals[indexPath.row]
    }
}
