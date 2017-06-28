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
        
        return false
    }
    
    public func cleanUpUserDefaults(){
        
    }
    
    public func initUserDefaults(){
        
    }
    
    public func setUserDefaultsValue(userKey:String, value:String){
        
    }
    
    public func getUserDefaultsValue(userKey:String) -> String {
        return ""
    }
}
