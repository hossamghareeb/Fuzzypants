//
//  NutritionFacts+CoreDataProperties.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension NutritionFacts {

    @NSManaged var calories: NSNumber?
    @NSManaged var carbohydrates: NSNumber?
    @NSManaged var cholesterol: NSNumber?
    @NSManaged var fats: NSNumber?
    @NSManaged var fiber: NSNumber?
    @NSManaged var potassium: NSNumber?
    @NSManaged var protein: NSNumber?
    @NSManaged var saturatedFats: NSNumber?
    @NSManaged var sodium: NSNumber?
    @NSManaged var sugar: NSNumber?
    @NSManaged var unsaturatedFats: NSNumber?
    @NSManaged var food: NSManagedObject?

}
