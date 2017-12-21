//
//  SurveyTaskListRow.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 22.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import ResearchKit

/**
 An enum that corresponds to a row displayed in a `TaskListViewController`.
 
 Each of the tasks is composed of one or more steps giving examples of the
 types of functionality supported by the ResearchKit framework.
 */
enum SurveyTaskListRow: Int, CustomStringConvertible {
    case personData = 0
    case equipmentLast4Hours
    case fitnessTest
    case endOfDay
    case qualityOfSleep
    case defaultBlock
    
    class SurveyTaskListRowSection {
        var title: String
        var rows: [SurveyTaskListRow]
        
        init(title: String, rows: [SurveyTaskListRow]) {
            self.title = title
            self.rows = rows
        }
    }
    
    /// Returns an array of all the task list row enum cases.
    static var sections: [ SurveyTaskListRowSection ] {
        return [
            SurveyTaskListRowSection(title: "Block A", rows:
                [
                    .personData,
                    ]),
            SurveyTaskListRowSection(title: "Block B", rows:
                [
                    .equipmentLast4Hours,
                    ]),
            SurveyTaskListRowSection(title: "Block C", rows:
                [
                    .fitnessTest,
                    ]),
            SurveyTaskListRowSection(title: "Block D", rows:
                [
                    .endOfDay,
                    ]),
            SurveyTaskListRowSection(title: "Block E", rows:
                [
                    .qualityOfSleep,
                    ]),
            SurveyTaskListRowSection(title: "Default Block", rows:
                [
                    .defaultBlock,
                    ]),
    ]}
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
        case .personData:
            return NSLocalizedString("Angaben zur Person", comment: "")
        
        case .equipmentLast4Hours:
            return NSLocalizedString("TODO: Genutzte Geräte", comment: "")
            
        case .fitnessTest:
            return NSLocalizedString("TODO: Fitnestest", comment: "")
        
        case .endOfDay:
            return NSLocalizedString("TODO: Konsumverhalten", comment: "")
            
        case .qualityOfSleep:
            return NSLocalizedString("TODO: Schlafqualität", comment: "")
            
        case .defaultBlock:
            return NSLocalizedString("Default Task", comment: "")
        }
    }
    
    
    // MARK: Properties
    
    /// Returns a new `ORKTask` that the `TaskListRow` enumeration represents.
    var representedTask: ORKTask {
        switch self {
        case .personData:
            return ToDoSurveyTask.sharedInstance.personalDataTask()
        case .equipmentLast4Hours:
            return ToDoSurveyTask.sharedInstance.equipmentUsedTask()
        case .fitnessTest:
            return ToDoSurveyTask.sharedInstance.fitnessTask()
        case .endOfDay:
            return ToDoSurveyTask.sharedInstance.endOfDayTask()
        case .qualityOfSleep:
            return ToDoSurveyTask.sharedInstance.defaultTask()
        case .defaultBlock:
            return ToDoSurveyTask.sharedInstance.defaultTask()
        }
    }
    
    // MARK: `ORKTask` Reused Text Convenience
    
    private var exampleDescription: String {
        return NSLocalizedString("Your description goes here.", comment: "")
    }
    
    private var exampleSpeechInstruction: String {
        return NSLocalizedString("Your more specific voice instruction goes here. For example, say 'Aaaah'.", comment: "")
    }
    
    private var exampleQuestionText: String {
        return NSLocalizedString("Your question goes here.", comment: "")
    }
    
    private var exampleHighValueText: String {
        return NSLocalizedString("High Value", comment: "")
    }
    
    private var exampleLowValueText: String {
        return NSLocalizedString("Low Value", comment: "")
    }
    
    private var exampleDetailText: String {
        return NSLocalizedString("Additional text can go here.", comment: "")
    }
    
    private var exampleEmailText: String {
        return NSLocalizedString("jappleseed@example.com", comment: "")
    }
    
    private var loremIpsumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
    }
    
    private var loremIpsumShortText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
    }
    
    private var loremIpsumMediumText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo?"
    }
    
    private var loremIpsumLongText: String {
        return "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam adhuc, meo fortasse vitio, quid ego quaeram non perspicis. Plane idem, inquit, et maxima quidem, qua fieri nulla maior potest. Quonam, inquit, modo? An potest, inquit ille, quicquam esse suavius quam nihil dolere? Cave putes quicquam esse verius. Quonam, inquit, modo?"
    }

}


