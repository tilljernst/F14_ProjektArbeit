//
//  SurveyHelper.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 31.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

struct SurveyHelper{
    /**
     creates a single text choice researchKit question step with one or multiple text-questions
     
     - Parameter identifier: unique identifier of the researchKit question
     - Parameter title: the title of the question
     - Parameter text: (optional) text below the title
     - Parameter items: the single question items with the corresponding answer in a tuple array
     
     - Returns: a researchKit ORKQuestionStep
     */
    static func createSingleTextChoiceQuestionStep(ORKQuestionIdentifier identifier:String, QuestionTitle title:String, QuestionText text:String = "", QuestionItems items:[(textChoice:String, answerValue:String)]) -> ORKQuestionStep {
        
        var textChoices = [ORKTextChoice]()
        for item in items {
            textChoices.append(ORKTextChoice(text: item.textChoice, value: item.answerValue as NSCoding & NSCopying & NSObjectProtocol))
        }
        
        let answerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: textChoices)
        
        let questionStep = ORKQuestionStep(identifier: identifier, title: title, answer: answerFormat)
        if text != "" {
            questionStep.text = text
        }
        return questionStep
    }
}
