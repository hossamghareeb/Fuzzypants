//
//  Food.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import CoreData


class Food: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    var oCategoryId: Int = 0
    
    class func newEntityWithOid(oid: NSNumber, oCategoryId: NSNumber, gramsPerServing: NSNumber, language: String, lastUpdatedDate: NSDate, pcsText: String, title: String, nutritionFacts: NutritionFacts, context: NSManagedObjectContext) -> Food{
        
        let food = NSEntityDescription.insertNewObjectForEntityForName("Food", inManagedObjectContext: context) as! Food
        food.oid = oid
        food.oCategoryId = oCategoryId.integerValue
        food.gramsPerServing = gramsPerServing
        food.language = language
        food.lastUpdated = lastUpdatedDate
        food.pcstext = pcsText
        food.title = title
        food.nutritionFacts = nutritionFacts
        return food
    }
}
