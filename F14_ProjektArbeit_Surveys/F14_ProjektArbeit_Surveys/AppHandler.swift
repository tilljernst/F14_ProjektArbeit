//
//  AppHandler.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation

public enum UserDefaultKey: String {
    case userId = "userId"
    case startDate = "startDate"
    case configurationDate = "configurationDate"
}

class AppHandler {
    
    class var sharedInstance : AppHandler {
        struct Static {
            static let instance: AppHandler = AppHandler()
        }
        return Static.instance
    }

    
    let userDefaultKeys: [UserDefaultKey] = {
        typealias k = UserDefaultKey
        return [
            k.userId,
            k.startDate,
            k.configurationDate
        ]
    }()
    
    // MARK: UserDefaults interaction
    
    func isUserConfigurationSet() -> Bool{
        let defaults = UserDefaults.standard
        var returnValue:Bool = true
        for key in userDefaultKeys {
            let value = defaults.string(forKey: key.rawValue)
            if ((value == nil) || (value == "")) {
                returnValue = false
            }
        }
        return returnValue
    }
    
    func cleanUpUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultKeys {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
    
    func initUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultKeys {
            defaults.set("", forKey: key.rawValue)
        }
    }
    
    func setUserDefaultsValue(userKey:String, value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: userKey)
    }
    
    func getUserDefaultsValue(userKey:String) -> String? {
        let defaults = UserDefaults.standard
        let returnValue:String?
        if let value = defaults.string(forKey: userKey) {
            returnValue = value as String
        }
        else {
            returnValue = nil
        }
        return returnValue
    }
        
    func setConfigurationDate(date: NSDate) {        
        let dateFormatter = getConfigDateFormatter()
        
        let configDate = dateFormatter.string(from: date as Date)
        
        setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: configDate)
    }
    
    func retrieveConfigurationDate() -> NSDate? {
        
        let dateFormatter = getConfigDateFormatter()
        
        let configDate = getUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate))
        
        let returnValue = dateFormatter.date(from: configDate!)
        
        return returnValue! as NSDate
    }
    
    func getConfigDateFormatter() -> DateFormatter {
        
        let dateFormatter = DateFormatter()
    
        dateFormatter.locale = Locale(identifier: "gsw_CH")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd-MM-yyyy HH:mm:ss")
        
        return dateFormatter
    }
    
    // MARK: 
}
