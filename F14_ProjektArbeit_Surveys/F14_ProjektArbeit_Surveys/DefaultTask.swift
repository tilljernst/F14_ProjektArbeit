//
//  DefaultTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 28.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

extension ToDoSurveyTask {
    func defaultTask() -> ORKTask {
        let instStep = ORKInstructionStep(identifier: String(describing:Identifier.operationInstructionStep))
        
        instStep.title = "Title of personal data"
        instStep.detailText = "This survey demonstrates different question types."
        instStep.text = "A description can goe here"
        
        let question1 = ORKQuestionStep(identifier: "question 1", title: "Have you ever been diagnosed with Softwareitis?", answer: ORKAnswerFormat.booleanAnswerFormat())
        
        let completionStep = ORKCompletionStep(identifier: "Completion Step")
        completionStep.title = "Thank you for taking this survey!"
        
        let task = ORKOrderedTask(identifier: "first survey", steps: [instStep, question1,/* question2, question3, question4, question5, question6,*/ completionStep])
        
        return task
    }
}
