//
//  Category.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import CoreData


class Category: NSManagedObject {
    
    
    lazy var title: String = {
        
        let code = NSLocale.currentLocale().languageISO
        let defaultCode = "en"
        var localizedString = ""
        var defaultString = ""
        if let translations = self.translations{
            for t in translations{
                let translation = t as! CategoryTranslation
                if translation.languageISO == code {
                    localizedString = translation.name!
                }
                if translation.languageISO == defaultCode {
                    defaultString = translation.name!
                }
            }
        }
        return localizedString.isEmpty ? defaultString : localizedString
        
    }()

// Insert code here to add functionality to your managed object subclass

    class func newEntityWithOid(oid: NSNumber, lastUpdatedDate: NSDate, context: NSManagedObjectContext) -> Category{
        
        let category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: context) as! Category
        category.oid = oid
        category.lastUpdatedDate = lastUpdatedDate
        return category
    }
}
