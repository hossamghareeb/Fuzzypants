//
//  AbstractDataLoader.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/1/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import Foundation
import UIKit
import CoreData
/**
 
 Abstract class for Data loading in the app.
 **Warning** This class is abstract class and shouldn't not be used as it, extend it.
 */
class AbstractDataLoader: NSObject {

    lazy var managedObjectContext: NSManagedObjectContext = {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        return app.managedObjectContext
    }()
    
    /// Get the json file name for your data to be parsed. The file name will be appended later with jsonFileDirectoryPath to get the whole file path. Must be overriden by subclasses. 
    /// - Returns: the data json file name.
    func jsonFileName() -> String{
        return ""
    }
    
    /// Return the directory path that contains all content json files. Override this function in your subclass to provide another directory than the default one. The defualt one is the main bundle directory.
    /// - Returns: The main bundle directory.
    func jsonFileDirectoryPath() -> String{
        
        return NSBundle.mainBundle().bundlePath
    }
    
    func entityName() -> String{
        return ""
    }
    
    func parseJsonData(json: AnyObject){
        // override by subclasses
    }
    
    func startLoadingData() -> AnyObject?{
        
        let directoryPath = jsonFileDirectoryPath() as NSString
        let fileName = jsonFileName()
        let filePath = directoryPath.stringByAppendingPathComponent(fileName)
        let fileManager = NSFileManager.defaultManager()
        if fileManager.fileExistsAtPath(filePath) {
            let data = NSData(contentsOfFile: filePath)
            do{
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                // Start parsing json data. Subclasses will do custom parsing here and any saving to database
                parseJsonData(json)
                return json
            }catch{
                
                print("Error in parsing JSON \(error)")
            }
            
        }
        else{
            print("File doesn't exist at \(filePath)")
        }
        
        
        return nil
    }
    
    
    func allRecords() -> [AnyObject]{
        let fetchRequest = NSFetchRequest(entityName: entityName())
        do{
            let records = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            return records
        }catch{
            print(error)
        }
        return []
    }
    
}
