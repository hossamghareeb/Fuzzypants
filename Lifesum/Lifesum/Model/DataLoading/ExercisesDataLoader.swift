//
//  ExercisesDataLoader.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/1/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

class ExercisesDataLoader: AbstractDataLoader {

    override class func jsonFileName() -> String {
        return "exercisesStatic.json"
    }
    
    override class func parseJsonData(json: AnyObject){
        let exercises = json as! [[String: AnyObject]]
        for exercise in exercises{
            parseExerciseObject(exercise)
        }
    }
    
    class func parseExerciseObject(json: [String: AnyObject]){
        
        let title = json["title"] as? String ?? ""
        let calories = (json["calories"] as? NSNumber ?? NSNumber(float: 0.0)).floatValue
        let oid = (json["oid"] as? NSNumber ?? NSNumber(integer: 0)).integerValue
        let lastupdatedInterval = (json["lastupdated"] as? NSNumber ?? NSNumber(integer: 0)).doubleValue
        let date = NSDate(timeIntervalSince1970: lastupdatedInterval)
        print("\(title) - \(date) - \(calories) - \(oid)")
        for key in json.keys where key.containsString("name"){
            print("\(key) -> \(json[key])")
        }
    }
}
