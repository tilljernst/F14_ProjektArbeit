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
enum SurveyTaskListRow: Int/*, CustomStringConvertible*/ {
    case personData = 0
    case equipmentLast4Hours
    case operationLast4Hours
    
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
                    .operationLast4Hours,
                    ]),
    ]}
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
            case .personData:
                return NSLocalizedString("Angaben zur Person", comment: "")
        
            case .equipmentLast4Hours:
                return NSLocalizedString("Geräte, die in den letzten vier Stunden beruflich oder privat genutzt wurden", comment: "")
            
            case .operationLast4Hours:
                return NSLocalizedString("Tätigkeiten, die in den letzten vier Stunden ausgeführt wurden", comment: "")
        }
    }
    
    // MARK: Types
    
    /**
     Every step and task in the ResearchKit framework has to have an identifier.
     Within a task, the step identifiers should be unique.
     
     Here we use an enum to ensure that the identifiers are kept unique. Since
     the enum has a raw underlying type of a `String`, the compiler can determine
     the uniqueness of the case values at compile time.
     
     In a real application, the identifiers for your tasks and steps might
     come from a database, or in a smaller application, might have some
     human-readable meaning.
     */
    private enum Identifier {
        // Task for personal datas
        case personTask
        case personInstructionStep
        case personGenderStep
        case personYearStep
        
        // Task for equipment usage
        case equipmentTask
        case equipmentInstructionStep
        case operationTask
        case operationInstructionStep
    }
    
    // MARK: Properties
    
    /// Returns a new `ORKTask` that the `TaskListRow` enumeration represents.
    var representedTask: ORKTask {
        switch self {
        case .personData:
            return personalDataTask
        case .equipmentLast4Hours:
            return equipmentTask
        case .operationLast4Hours:
            return operationTask
        }
    }

    // MARK: Task Creation Convenience
    
    /**
     This task is available in survey Block A and collects personal datas of the person
     */
    private var personalDataTask: ORKTask {
        let instStep = ORKInstructionStep(identifier: String(describing:Identifier.personInstructionStep))
        
        instStep.title = "Title of personal data"
        instStep.detailText = "This survey demonstrates different question types."
        instStep.text = exampleDescription
        
        let question1 = ORKQuestionStep(identifier: "question 1", title: "Have you ever been diagnosed with Softwareitis?", answer: ORKAnswerFormat.booleanAnswerFormat())
        
        let completionStep = ORKCompletionStep(identifier: "Completion Step")
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: "first survey", steps: [instStep, question1,/* question2, question3, question4, question5, question6,*/ completionStep])

        return task
        //return ORKOrderedTask(identifier: String(describing:Identifier.formTask), steps: [step])
    }
    
    private var equipmentTask: ORKTask {
        let instStep = ORKInstructionStep(identifier: String(describing:Identifier.equipmentInstructionStep))
        
        instStep.title = "Title of personal data"
        instStep.detailText = "This survey demonstrates different question types."
        instStep.text = exampleDescription
        
        let question1 = ORKQuestionStep(identifier: "question 1", title: "Have you ever been diagnosed with Softwareitis?", answer: ORKAnswerFormat.booleanAnswerFormat())

        let completionStep = ORKCompletionStep(identifier: "Completion Step")
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: "first survey", steps: [instStep, question1,/* question2, question3, question4, question5, question6,*/ completionStep])
        
        return task
    }
    
    private var operationTask: ORKTask {
        let instStep = ORKInstructionStep(identifier: String(describing:Identifier.operationInstructionStep))
        
        instStep.title = "Title of personal data"
        instStep.detailText = "This survey demonstrates different question types."
        instStep.text = exampleDescription
        
        let question1 = ORKQuestionStep(identifier: "question 1", title: "Have you ever been diagnosed with Softwareitis?", answer: ORKAnswerFormat.booleanAnswerFormat())
        
        let completionStep = ORKCompletionStep(identifier: "Completion Step")
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: "first survey", steps: [instStep, question1,/* question2, question3, question4, question5, question6,*/ completionStep])
        
        return task
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


