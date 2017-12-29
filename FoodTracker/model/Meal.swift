//
//  Meal.swift
//  FoodTracker
//
//  Created by nguyencuong on 12/25/17.
//  Copyright © 2017 nguyencuong. All rights reserved.
//

import Foundation
import UIKit

class Meal: NSObject, NSCoding {
    
    //MARK: Archiving Paths
    
    var name: String
    var  photo: UIImage?
    var rating: Int
    
    
    struct PropertiesKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertiesKey.name)
        aCoder.encode(photo, forKey: PropertiesKey.photo)
        aCoder.encode(rating, forKey: PropertiesKey.rating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: PropertiesKey.name) as? String else { return nil }
        let photo = aDecoder.decodeObject(forKey: PropertiesKey.photo) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertiesKey.rating)
        self.init(name: name, photo: photo, rating: rating)
    }
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?,rating: Int) {
        
        guard !name.isEmpty else {
            return nil
        }
        
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    
    
    
    
}
