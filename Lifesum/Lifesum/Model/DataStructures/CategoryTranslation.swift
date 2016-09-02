//
//  CategoryTranslation.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import CoreData


class CategoryTranslation: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func newEntityWithLanguageISO(language: String, name: String, context: NSManagedObjectContext) -> CategoryTranslation{
        
        let translation = NSEntityDescription.insertNewObjectForEntityForName("CategoryTranslation", inManagedObjectContext: context) as! CategoryTranslation
        translation.languageISO = language
        translation.name = name
        return translation
    }
}
