//
//  CategoryDataLoader.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit
import CoreData

class CategoryDataLoader: AbstractDataLoader {

    override func jsonFileName() -> String {
        return "categoriesStatic.json"
    }
    
    override func parseJsonData(json: AnyObject){
        let categories = json as! [[String: AnyObject]]
        for category in categories{
            parseCategoryObject(category)
        }
    }
    
    func parseCategoryObject(json: [String: AnyObject]){

        let categoryTitle = json.stringWithKey("category")
        let oid = json.numberWithKey("oid")
        let lastupdatedInterval = (json.numberWithKey("lastupdated")).doubleValue
        let date = NSDate(timeIntervalSince1970: lastupdatedInterval)
        
        let category = Category.newEntityWithOid(oid, lastUpdatedDate: date, context: self.managedObjectContext)
        
        let localizedNames = NSMutableSet()
        for key in json.keys where key.containsString("name"){
            
            let components = key.componentsSeparatedByString("_")
            if components.count == 2 {
                let languageCode = components[1] as String
                let localizedName = json.stringWithKey(key)
                
                let translation = CategoryTranslation.newEntityWithLanguageISO(languageCode, name: localizedName, context: self.managedObjectContext)
                
                localizedNames.addObject(translation)
            }
        }
        
        // Let's add the title as translation for English
        let englishTitle = CategoryTranslation.newEntityWithLanguageISO("en", name: categoryTitle, context: self.managedObjectContext)
        localizedNames.addObject(englishTitle)
        
        category.translations = localizedNames
        
        do{
            try self.managedObjectContext.save()
        }catch{
            print(error)
        }
    }
    
    
    override func entityName() -> String {
        return "Category"
    }
    
    override func dataLoadedKey() -> String {
        return "CategoriesData"
    }
}
