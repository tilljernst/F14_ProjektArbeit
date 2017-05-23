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
    case operationLast4Hours
    case fitnesTest
    case consumptionSurvey
    case qualityOfSleep
    
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
            SurveyTaskListRowSection(title: "Block C", rows:
                [
                    .fitnesTest,
                    ]),
            SurveyTaskListRowSection(title: "Block D", rows:
                [
                    .consumptionSurvey,
                    ]),
            SurveyTaskListRowSection(title: "Block E", rows:
                [
                    .qualityOfSleep,
                    ]),
    ]}
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
        case .personData:
            return NSLocalizedString("Angaben zur Person", comment: "")
        
        case .equipmentLast4Hours:
            return NSLocalizedString("TODO: Genutzte Geräte", comment: "")
            
        case .operationLast4Hours:
            return NSLocalizedString("TODO: Ausgeführte Tätigkeiten", comment: "")
            
        case .fitnesTest:
            return NSLocalizedString("TODO: Fitnestest", comment: "")
        
        case .consumptionSurvey:
            return NSLocalizedString("TODO: Konsumverhalten", comment: "")
            
        case .qualityOfSleep:
            return NSLocalizedString("TODO: Schlafqualität", comment: "")
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
        case personFormStep
        case personGenderStep
        case personYearStep
        case personHeightStep
        case personWeightStep
        case personCompletionStep
        
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
            return defaultTask
        case .operationLast4Hours:
            return defaultTask
        case .fitnesTest:
            return defaultTask
        case .consumptionSurvey:
            return defaultTask
        case .qualityOfSleep:
            return defaultTask
        }
    }

    // MARK: Task Creation Convenience
    
    /**
     This task is available in survey Block A and collects personal data
     */
    private var personalDataTask: ORKTask {
        
        // Intro step
        let personInstructionStep = ORKInstructionStep(identifier: String(describing:Identifier.personInstructionStep))
        
        personInstructionStep.title = "Angaben zur Person"
        personInstructionStep.text = "Zuerst folgen ein paar Angaben zu Ihrer Person:"
        
        // gender
        let genderAnswerFormat = ORKBooleanAnswerFormat(yesString: "weiblich", noString: "männlich")
        let genderQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personGenderStep), title: "Gschlecht", answer: genderAnswerFormat)
        
        // year
        let yearAnswerFormat = ORKAnswerFormat.decimalAnswerFormat(withUnit: NSLocalizedString("Jahr", comment: ""))
        yearAnswerFormat.minimum = 1900
        //        // set current year for maximum value
        let calendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        yearAnswerFormat.maximum = (calendar?.component(NSCalendar.Unit.year, from: Date()))! as NSNumber?
        let yearQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personYearStep), title: "Jahrgang", answer: yearAnswerFormat)
        
        // height
        let heightAnswerFormat = ORKHeightAnswerFormat.init(measurementSystem: ORKMeasurementSystem.metric)
        let heightQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personHeightStep), title: "Grösse", answer: heightAnswerFormat)
        
        // weight
        let weightAnswerFormat = ORKNumericAnswerFormat.decimalAnswerFormat(withUnit: "kg")
        let weightQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personWeightStep), title: "Gewicht", answer: weightAnswerFormat)
        
        // TODO: Lebensform
        
        // TODO: Kinder
        
        // TODO: Alter der Kinder
        
        // TODO: Tage an denen Kinder fremdbetreut sind
        
        // TODO: Person in Haushalt
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.personCompletionStep))
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: String (describing:Identifier.personTask), steps: [personInstructionStep, genderQuestion, yearQuestion, heightQuestion, weightQuestion, completionStep])

        return task
    }
    
    
    private var defaultTask: ORKTask {
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


