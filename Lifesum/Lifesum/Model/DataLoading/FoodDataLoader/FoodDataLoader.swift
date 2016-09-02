//
//  FoodDataLoader.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class FoodDataLoader: AbstractDataLoader {

    override func jsonFileName() -> String {
        return "foodStatic.json"
    }
    
    override func parseJsonData(json: AnyObject){
        let foods = json as! [[String: AnyObject]]
        
        // prepare categories
        let categories = CategoryDataLoader().allRecords() as! [Category]
        var hashTable = [Int: NSMutableSet]()
        for cat in categories {
            if let oid  = cat.oid?.integerValue{
                hashTable[oid] = NSMutableSet()
            }
        }
        
        for foodJson in foods{
            let food = parseFoodObject(foodJson)
            let set = hashTable[food.oCategoryId]
            set?.addObject(food)
        }
        
        for cat in categories {
            if let oid  = cat.oid?.integerValue{
                cat.foods = hashTable[oid]
            }
        }
        
        do{
            try self.managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    func parseFoodObject(json: [String: AnyObject]) -> Food{
        
        let nutritionFacts = parseNutritionObject(json)
        let gramsPerServing = json.numberWithKey("gramsperserving")
        let language = json.stringWithKey("language")
        let pcsText = json.stringWithKey("pcstext")
        let lastupdatedInterval = (json.numberWithKey("lastupdated")).doubleValue
        let date = NSDate(timeIntervalSince1970: lastupdatedInterval)
        let categoryId = json.numberWithKey("ocategoryid")
        let oid = json.numberWithKey("oid")
        let title = json.stringWithKey("title")
        
        let food = Food.newEntityWithOid(oid, oCategoryId: categoryId, gramsPerServing: gramsPerServing, language: language, lastUpdatedDate: date, pcsText: pcsText, title: title, nutritionFacts: nutritionFacts, context: self.managedObjectContext)
        return food
    }
    
    func parseNutritionObject(json: [String: AnyObject]) -> NutritionFacts{
        
        let calories = json.numberWithKey("calories")
        let carbohydrates = json.numberWithKey("carbohydrates")
        let chelosterol = json.numberWithKey("cholesterol")
        let fats = json.numberWithKey("fat")
        let fiber = json.numberWithKey("fiber")
        let potassium = json.numberWithKey("potassium")
        let protein = json.numberWithKey("protein")
        let saturatedFats = json.numberWithKey("saturatedfat")
        let sodium = json.numberWithKey("sodium")
        let sugar = json.numberWithKey("sugar")
        let unsaturatedFats = json.numberWithKey("unsaturatedfat")
        
        let nutritionFacts = NutritionFacts.newEntityWithCalories(calories, carbs: carbohydrates, cholesterol: chelosterol, fats: fats, fiber: fiber, potassium: potassium, protein: protein, saturatedFats: saturatedFats, sodium: sodium, sugar: sugar, unsaturatedFats: unsaturatedFats, context: self.managedObjectContext)
        return nutritionFacts
    }
    
}
