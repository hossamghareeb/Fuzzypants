//
//  DataManager.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/1/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

/// Data Manager acts as a Facade design pattern to load all data from json files and persist them in DataBase (CoreData)
class DataManager: NSObject {

    /**
     Load all json data files and persis them in database. As this job is heavy, it will be executed in background and the handler will be called in main thread.
     - Parameter handler: completion handler to be called after completion.
     */
    class func loadAllData(handler: () -> ()){
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) { 
            
            let exerciesesManager = ExercisesDataLoader()
            exerciesesManager.startLoadingData()
            let categoriesManager = CategoryDataLoader()
            categoriesManager.startLoadingData()
            
            let foodsManager = FoodDataLoader()
            foodsManager.startLoadingData()
                    
            dispatch_async(dispatch_get_main_queue(), { 
                
                handler()
            })
        }
    }
}
