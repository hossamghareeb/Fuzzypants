//
//  Utils.swift
//  Lifesum
//
//  Created by Hossam Ghareeb on 9/2/16.
//  Copyright © 2016 Hossam Ghareeb. All rights reserved.
//

import UIKit

extension NSLocale{
    
    var languageISO: String{
        get{
            let currentLanguage = NSLocale.preferredLanguages().first
            let languageDic = NSLocale.componentsFromLocaleIdentifier(currentLanguage!)
            let code = languageDic["kCFLocaleLanguageCodeKey"]
            return code!
        }
    }
}

extension Dictionary{
    
    func stringWithKey(key: Key) -> String{
        return self[key] as? String ?? ""
    }
    
    func numberWithKey(key: Key) -> NSNumber{
        return self[key] as? NSNumber ?? NSNumber(integer: 0)
    }
}
