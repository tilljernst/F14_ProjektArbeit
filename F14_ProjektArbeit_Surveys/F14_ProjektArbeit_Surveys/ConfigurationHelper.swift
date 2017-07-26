//
//  ConfigurationHelper.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit
import UserNotifications

extension ConfigurationViewController {
    
    // reads user configurations and puts them into UserDefaults
    func setUserConfiguration(ConfigurationResult result: ORKTaskResult){
        // read config result as ORKTaskResult
        let configTaskResults = result
        print(configTaskResults)
        var heartRateId:String = ""
        var startDate:String = ""
        var configDate:String = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
        configDate = dateFormatter.string(from: configTaskResults.startDate)
        print("configurationDate \(String(describing: configDate))")
        // read every step result as ORKStepResult
        for stepResult in configTaskResults.results! as! [ORKStepResult]  {
            // read the answers in every step, if available
            for result in stepResult.results! {
                print("Identifier \(result.identifier)")
                print("Result \(result)")
                switch(stepResult.identifier){
                // read heart rate id as ORKTextQuestionResult
                case(String(describing:Identifier.configurationHeartRateIdStep)):
                    let heartRateResult = result as! ORKTextQuestionResult
                    heartRateId = heartRateResult.textAnswer!
                    print("Value is \(String(describing: heartRateId))")
                // read start date
                case (String(describing:Identifier.configurationStartDateStep)):
                    let startDateResult = result as! ORKDateQuestionResult
                    dateFormatter.dateFormat = "dd.MM.YYYY"
                    startDate = dateFormatter.string(from: startDateResult.dateAnswer!)
                    print("dateAnswer \(String(describing: startDate))")
                    print("calendar \(String(describing: startDateResult.calendar))")
                    print("timeZone \(String(describing: startDateResult.timeZone))")
                default:break
                }
            }
        }
        let appHandler = AppHandler()
        appHandler.initUserDefaults()
        appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.userId), value: heartRateId)
        appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.startDate), value: startDate)
        appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: configDate)
    }
    
    func initializeLocalSurveyNotifications() {
        
    }

}
