//
//  ExercisesDataLoader.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/1/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreData
class ExercisesDataLoader: AbstractDataLoader {

    override func jsonFileName() -> String {
        return "exercisesStatic.json"
    }
    
    override func parseJsonData(json: AnyObject){
        let exercises = json as! [[String: AnyObject]]
        for exercise in exercises{
            parseExerciseObject(exercise)
        }
    }
    
    func parseExerciseObject(json: [String: AnyObject]){
        
        let title = json.stringWithKey("title")
        let calories = json.numberWithKey("calories")
        let oid = json.numberWithKey("oid")
        let lastupdatedInterval = (json.numberWithKey("lastupdated")).doubleValue
        let date = NSDate(timeIntervalSince1970: lastupdatedInterval)
        
        let exercise = Exercise.newEntityWithCalories(calories, oid: oid, lastUpdatedDate: date, context: self.managedObjectContext)
        
        let localizedNames = NSMutableSet()
        for key in json.keys where key.containsString("name"){
            
            let components = key.componentsSeparatedByString("_")
            if components.count == 2 {
                let languageCode = components[1] as String
                let localizedName = json.stringWithKey(key)
                
                let translation = ExerciseTranslation.newEntityWithLanguageISO(languageCode, name: localizedName, context: self.managedObjectContext)
                
                localizedNames.addObject(translation)
            }
        }
        
        // Let's add the title as translation for English
        let englishTitle = ExerciseTranslation.newEntityWithLanguageISO("en", name: title, context: self.managedObjectContext)
        localizedNames.addObject(englishTitle)
        
        exercise.translations = localizedNames
        
        do{
            try self.managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    override func entityName() -> String {
        return "Exercise"
    }
    
    func exercisesWithKeyword(keyword: String) -> [AnyObject] {
        
        let code = NSLocale.currentLocale().languageISO
        let predicate: NSPredicate? = keyword.characters.count == 0 ? nil : NSPredicate(format: "SUBQUERY(translations, $t, $t.languageISO = '\(code)' AND $t.name CONTAINS '\(keyword)').@count > 0", keyword)
        return allRecords(predicate)
    }
}
