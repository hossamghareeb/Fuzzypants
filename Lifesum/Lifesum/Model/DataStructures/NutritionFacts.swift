//
//  NutritionFacts.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import CoreData


class NutritionFacts: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    class func newEntityWithCalories(calories: NSNumber, carbs: NSNumber, cholesterol: NSNumber, fats: NSNumber, fiber: NSNumber, potassium: NSNumber, protein: NSNumber, saturatedFats: NSNumber, sodium: NSNumber, sugar: NSNumber, unsaturatedFats: NSNumber, context: NSManagedObjectContext) -> NutritionFacts{
        
        let nutritionFacts = NSEntityDescription.insertNewObjectForEntityForName("NutritionFacts", inManagedObjectContext: context) as! NutritionFacts
        nutritionFacts.calories = calories
        nutritionFacts.carbohydrates = carbs
        nutritionFacts.cholesterol = cholesterol
        nutritionFacts.fats = fats
        nutritionFacts.fiber = fiber
        nutritionFacts.potassium = potassium
        nutritionFacts.protein = protein
        nutritionFacts.saturatedFats = saturatedFats
        nutritionFacts.sodium = sodium
        nutritionFacts.sugar = sugar
        nutritionFacts.unsaturatedFats = unsaturatedFats
        return nutritionFacts
    }
}
