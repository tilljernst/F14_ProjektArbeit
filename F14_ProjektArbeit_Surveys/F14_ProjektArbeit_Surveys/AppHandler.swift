//
//  AppHandler.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation


class AppHandler {
    
    enum userDefaultKey: String {
        case userId = "userId"
        case startDate = "startDate"
    }
    
    let userDefaultKeys: [userDefaultKey] = {
        typealias k = userDefaultKey
        return [
            k.userId,
            k.startDate
        ]
    }()
    
    // MARK: UserDefaults interaction
    
    public func isUserConfigurationSet() -> Bool{
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
    
    public func cleanUpUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultKeys {
            defaults.removeObject(forKey: key.rawValue)
        }
    }
    
    public func initUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultKeys {
            defaults.set("", forKey: key.rawValue)
        }
    }
    
    public func setUserDefaultsValue(userKey:String, value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: userKey)
    }
    
    public func getUserDefaultsValue(userKey:String) -> String? {
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
}
