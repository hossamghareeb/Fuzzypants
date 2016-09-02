//
//  Exercise+CoreDataProperties.swift
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

extension Exercise {

    @NSManaged var calories: NSNumber?
    @NSManaged var lastUpdatedDate: NSDate?
    @NSManaged var oid: NSNumber?
    @NSManaged var translations: NSSet?

}
