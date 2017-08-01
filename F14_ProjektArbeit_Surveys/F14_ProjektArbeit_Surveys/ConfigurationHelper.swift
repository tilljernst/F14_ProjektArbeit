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
        var startDate = Date()
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
                    let startDateResult = result as? ORKDateQuestionResult
                    startDate = (startDateResult?.dateAnswer)!
                    print("dateAnswer \(String(describing: startDate))")
                    let calendar = Calendar.current
                    startDate = calendar.date(bySettingHour: 10, minute: 0, second: 0, of: startDate)!
                    print("configuredStartDate \(String(describing: startDate))")
                    print("calendar \(String(describing: startDateResult?.calendar))")
                    print("timeZone \(String(describing: startDateResult?.timeZone))")
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
        let startDate = UserDefaultHandler.sharedInstance.retrieveStartDate()
        let calendar = Calendar.current
        var dateComponent = DateComponents()
        
        // Tag 1.; 10:00Uhr; Block A
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: startDate!, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockA_personalData)
        )
        
        // Tag 1.; 14:00Uhr; Block B & C (Fitness)
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockC_fitnessTest)
        )
        
        // Tag 1.; 18:00Uhr; Block B & E (Schlaf)
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockE_sleepQuality)
        )
        
        // Tag 1.; 22:00Uhr; Block B & D
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: startDate! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockD_endOfDay)
        )
        
        // Tag 2.
        // -------------------------
        dateComponent.day = 1
        let dayTwo = calendar.date(byAdding: dateComponent, to: startDate! as Date)
        
        // Tag 2.; 14:00Uhr; Block B & C (Fitness)
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 14, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockC_fitnessTest)
        )
        
        // Tag 2.; 18:00Uhr; Block B & E (Schlaf)
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockE_sleepQuality)
        )
        
        // Tag 2.; 22:00Uhr; Block B & D
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockB_equipmentUsed)
        )
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: dayTwo! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockD_endOfDay)
        )
        
        // Tag 3.
        // -------------------------
        dateComponent.day = 2
        let dayThree = calendar.date(byAdding: dateComponent, to: startDate! as Date)
        
        // Tag 3.; 18:00Uhr; Block E (Schlaf)
        ToDoSurveyList.sharedInstance.addItem(
            TodoSurveyItem(deadline: calendar.date(bySettingHour: 18, minute: 0, second: 0, of: dayThree! as Date)! as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.blockE_sleepQuality)
        )
        
        // TODO: Remove the following code when finished
        // test items for local notifications
        let currentDate = Date()
        dateComponent.day = 0
        dateComponent.minute = 1
        dateComponent.second = 0
        let comp = calendar.dateComponents([.hour, .minute], from: currentDate)
        let hour = comp.hour
        let minute = comp.minute
        var testDateOne = calendar.date(bySettingHour: hour!, minute: minute!, second: 0, of: currentDate)
        testDateOne = calendar.date(byAdding: dateComponent, to: testDateOne!)!
        ToDoSurveyList.sharedInstance.addItem(TodoSurveyItem(surveyTitle: "Test Item after 2 Minutes",deadline: testDateOne! as NSDate,  UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.defaultTask)) // schedule a local notification to persist this item
        dateComponent.minute = 2
        let testDateTwo = calendar.date(byAdding: dateComponent, to: testDateOne!)!
        ToDoSurveyList.sharedInstance.addItem(TodoSurveyItem(surveyTitle: "Test Item after 5 Minutes",deadline: testDateTwo as NSDate, UUID: UUID().uuidString, surveyTaskId: SurveyTaskId.defaultTask)) // schedule a local notification to persist this item
    }

}
