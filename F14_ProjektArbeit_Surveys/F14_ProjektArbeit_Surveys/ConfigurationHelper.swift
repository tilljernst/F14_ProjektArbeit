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
        var startDate:Date = Date()
        let dateFormatter = UserDefaultHandler.sharedInstance.getConfigDateFormatter()
        let configurationDate = dateFormatter.string(from: configTaskResults.startDate)
        print("configurationDate \(String(describing: configurationDate))")
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
                    let configDate = result as? ORKDateQuestionResult
                    startDate = (configDate?.dateAnswer)!
                    let calendar = Calendar.current
                    startDate = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: startDate)!
                    print("dateAnswer \(String(describing: startDate))")
                    print("calendar \(String(describing: configDate?.calendar))")
                    print("timeZone \(String(describing: configDate?.timeZone))")
                default:break
                }
            }
        }
        UserDefaultHandler.sharedInstance.initUserDefaults()
        UserDefaultHandler.sharedInstance.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.userId), value: heartRateId)
        UserDefaultHandler.sharedInstance.setStartDate(date: startDate as NSDate)
        UserDefaultHandler.sharedInstance.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: configurationDate)
    }
    
    func initializeLocalSurveyNotifications() {
        // add all the timers for the survey
        let currentDate = NSDate()
        let startDate = UserDefaultHandler.sharedInstance.retrieveStartDate()
        
        
        
        // Tag 1.; 10:00Uhr; Block A
        
        // Tag 1.; 14:00Uhr; Block B & C (Fitness)
        
        // Tag 1.; 18:00Uhr; Block B & E (Schlaf)
        
        // Tag 1.; 22:00Uhr; Block B & D
        
        // Tag 2.; 14:00Uhr; Block B & C (Fitness)
        
        // Tag 2.; 18:00Uhr; Block B & E (Schlaf)
        
        // Tag 2.; 22:00Uhr; Block B & D
        
        // Tag 3.; 18:00Uhr; Block E (Schlaf)
        
        
        let todoItem = TodoSurveyItem(deadline: currentDate, surveyTitle: "here comes the title of the survey", UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.personalData)
        ToDoSurveyList.sharedInstance.addItem(todoItem) // schedule a local notification to persist this item
    }

}
