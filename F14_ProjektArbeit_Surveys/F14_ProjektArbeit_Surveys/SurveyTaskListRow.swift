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
    case personalData = 0
    
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
                    .personalData,
                    ]),
            SurveyTaskListRowSection(title: "Block B", rows:
                [
                    .personalData,
                    ]),
    ]}
    
    // MARK: CustomStringConvertible
    
    var description: String {
        switch self {
        case .personalData:
            return NSLocalizedString("Survey: Angaben zur Person", comment: "")
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
        case personalTask
        case personalStep
        // tbd
    }
    
    // MARK: Properties
    
    /// Returns a new `ORKTask` that the `TaskListRow` enumeration represents.
    var representedTask: ORKTask {
        switch self {
        case .personalData:
            return personalTask
        }
    }

    // MARK: Task Creation Convenience
    
    /**
     This task is available in survey Block A and collects personal datas of the person
     */
    private var personalTask: ORKTask {
        let instStep = ORKInstructionStep(identifier: "Instruction Step")
        instStep.title = "Softwareitis Survey"
        instStep.detailText = "This survey demonstrates different question types."
        instStep.text = exampleDescription
        
        let question1 = ORKQuestionStep(identifier: "question 1", title: "Have you ever been diagnosed with Softwareitis?", answer: ORKAnswerFormat.booleanAnswerFormat())
        
        let question2 = ORKQuestionStep(identifier: "question 2", title: "How many apps do you download per week?", answer: ORKAnswerFormat.integerAnswerFormat(withUnit: "Apps per week"))
        
        let answerFormat3 = ORKNumericAnswerFormat.scale(withMaximumValue: 10, minimumValue: 0, defaultValue: 5, step: 1, vertical: false, maximumValueDescription: nil, minimumValueDescription: nil)
        let question3 = ORKQuestionStep(identifier: "question 3", title: "How many apps do you download per week (range)?", answer: answerFormat3)
        
        let textChoice1 = ORKTextChoice(text: "Games", detailText: nil, value: 1 as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
        let textChoice2 = ORKTextChoice(text: "Lifestyle", detailText: nil, value: 2 as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
        let textChoice3 = ORKTextChoice(text: "Utility", detailText: nil, value: 3 as NSCoding & NSCopying & NSObjectProtocol, exclusive: false)
        let answerFormat4 = ORKNumericAnswerFormat.choiceAnswerFormat(with: ORKChoiceAnswerStyle.singleChoice, textChoices: [textChoice1, textChoice2, textChoice3])
        let question4 = ORKQuestionStep(identifier: "question 4", title: "Which category of apps do you download the most?", answer: answerFormat4)
        
        let answerFormat5 = ORKNumericAnswerFormat.dateAnswerFormat()
        let question5 = ORKQuestionStep(identifier: "question 5", title: "When did you last download an app?", answer: answerFormat5)
        
        let answerFormat6 = ORKNumericAnswerFormat.timeIntervalAnswerFormat()
        let question6 = ORKQuestionStep(identifier: "question 6", title: "When did you last open an app?", answer: answerFormat6)
        
        let completionStep = ORKCompletionStep(identifier: "Completion Step")
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: "first survey", steps: [instStep, question1, question2, question3, question4, question5, question6, completionStep])

        return task
        //return ORKOrderedTask(identifier: String(describing:Identifier.formTask), steps: [step])
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


