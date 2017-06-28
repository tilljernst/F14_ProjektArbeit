//
//  AppHandler.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation


class AppHandler {
    
    let userDefaultsKey = [
        "userId",
        "startDate"
    ]
    
    // MARK: UserDefaults interaction
    
    public func isUserConfigurationSet() -> Bool{
        let defaults = UserDefaults.standard
        var returnValue:Bool = true
        for key in userDefaultsKey {
            if ((defaults.object(forKey: key) as? NSData) == nil) {
                returnValue = false
            }
        }
        return returnValue
    }
    
    public func cleanUpUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultsKey {
            if ((defaults.object(forKey: key) as? NSData) != nil) {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    public func initUserDefaults(){
        let defaults = UserDefaults.standard
        for key in userDefaultsKey {
            defaults.set("", forKey: key)
        }
    }
    
    public func setUserDefaultsValue(userKey:String, value:String){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: userKey)
    }
    
    public func getUserDefaultsValue(userKey:String) -> String {
        let defaults = UserDefaults.standard
        let returnValue:String?
        if let value = defaults.object(forKey: userKey) as? NSString {
            returnValue = value as String
        }
        else {
            returnValue = nil
        }
        return returnValue!
    }
}
