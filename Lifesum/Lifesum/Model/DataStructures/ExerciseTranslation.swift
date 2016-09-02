//
//  ExerciseTranslation.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import CoreData


class ExerciseTranslation: NSManagedObject {

// Insert code here to add functionality to your managed object subclass

    class func newEntityWithLanguageISO(language: String, name: String, context: NSManagedObjectContext) -> ExerciseTranslation{
        
        let translation = NSEntityDescription.insertNewObjectForEntityForName("ExerciseTranslation", inManagedObjectContext: context) as! ExerciseTranslation
        translation.languageISO = language
        translation.name = name
        return translation
    }
}
