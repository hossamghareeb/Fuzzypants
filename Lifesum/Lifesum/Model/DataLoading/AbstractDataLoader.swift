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

    /// The managedObjectContext for core data.
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
    
    /// Get the entity name for the current loader. override this method to provide the correce entity name. 
    /// - Returns: the entity name for the current objects we read from json file.
    func entityName() -> String{
        return ""
    }
    
    /// Start parsing the json data that we parsed from json file. 
    /// - Parameter json: The json object that has been parsed from json file.
    func parseJsonData(json: AnyObject){
        // override by subclasses
    }
    
    /// call this function to start loadint the data from json file and parse it to be persisted in core data.
    func startLoadingData() -> AnyObject?{
        if isDataAlreadyLoaded(){
            return nil
        }
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
                markDataAsLoaded()
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
    
    /// Get all records in data base for the current entity. This function will ask subclasses for th exaxt entity name to read from core data. 
    /// - Parameter predicate: The NSPredicate used to filter data. By default it's nil which means no predicate to be used. 
    /// - Returns: Array of objacts for the specific entity from coredata.
    func allRecords(predicate: NSPredicate? = nil) -> [AnyObject]{
        let fetchRequest = NSFetchRequest(entityName: entityName())
        fetchRequest.predicate = predicate
        do{
            let records = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            return records
        }catch{
            print(error)
        }
        return []
    }
    
    /// Mark that the current data is already loaded in core data to prevent loadint them again.
    private func markDataAsLoaded(){
        NSUserDefaults.standardUserDefaults().setBool(true, forKey: dataLoadedKey())
    }
    
    /// Check whether current data is already loaded in database or not. 
    /// - Returns: true if data is already loaded, false othewise.
    private func isDataAlreadyLoaded() -> Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey(dataLoadedKey())
    }
    
    /// The current key used to save the flag in user defaults. Override this function by subclasses to provide the correct key.
    func dataLoadedKey() -> String{
        return ""
    }
}
