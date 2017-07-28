//
//  PersonalDataTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 28.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

extension ToDoSurveyTask{
    /**
     This task is available in survey Block A and collects personal data
     */
    func personalDataTask() -> ORKTask {
        
        let standardQuestionsAndValues = [
            ("1","1"),
            ("2","2"),
            ("3","3"),
            ("4 oder mehr","4")
        ]
        
        // Intro step
        let personInstructionStep = ORKInstructionStep(identifier: String(describing:Identifier.personInstructionStep))
        
        personInstructionStep.title = "Angaben zur Person"
        personInstructionStep.text = "Zuerst folgen ein paar Angaben zu Ihrer Person:"
        
        // gender
        let genderAnswerFormat = ORKBooleanAnswerFormat(yesString: "weiblich", noString: "männlich")
        let genderQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personGenderStep), title: "Geschlecht", answer: genderAnswerFormat)
        
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
        
        // lifeForm
        let lifeFormQuestionsAndValues = [
            ("alleinstehend","1"),
            ("Partnerschaft","2"),
            ("in einer WG","3")
        ]
        let lifeFormQuestion = SurveyHelper.createSingleTextChoiceQuestionStep(ORKQuestionIdentifier: String(describing: Identifier.personLifeFormStep), QuestionTitle: "Lebensform", QuestionItems: lifeFormQuestionsAndValues)
        
        // kids (conditional question)
        // ----------------------------
        let kidsAnswerFormat = ORKBooleanAnswerFormat(yesString: "Ja", noString: "Nein")
        let kidsStep = ORKQuestionStep(identifier: String(describing:Identifier.personKidsStep), title: "Haben Sie Kinder?", answer: kidsAnswerFormat)
        kidsStep.isOptional = false
        
        // total kids
        let totalKidsAnswerFormat = ORKNumericAnswerFormat.decimalAnswerFormat(withUnit: "Anzahl Kinder")
        let totalKidsQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personKidsTotalStep), title: "Wieviele Kinder haben Sie?", answer: totalKidsAnswerFormat)
        
        // age of the kids
        let kidsAgeFormStep = ORKFormStep(identifier: String(describing:Identifier.personKidsAgeFormStep))
        kidsAgeFormStep.title = "Wie alt sind Ihre Kinder?"
        
        let kidsAgeAnswerFormat = ORKNumericAnswerFormat.decimalAnswerFormat(withUnit: nil)
        kidsAgeAnswerFormat.minimum = 1900
        //        // set current year for maximum value
        let kidsCalendar = NSCalendar.init(calendarIdentifier: NSCalendar.Identifier.gregorian)
        kidsAgeAnswerFormat.maximum = (kidsCalendar?.component(NSCalendar.Unit.year, from: Date()))! as NSNumber?
        
        var formItemFirstChild = ORKFormItem(identifier: String(describing:Identifier.personKidsAgeFormItemFirst), text: "Jahrgang des ersten Kindes (ältestes)", answerFormat: kidsAgeAnswerFormat)
        
        var formItemSecondChild = ORKFormItem(identifier: String(describing:Identifier.personKidsAgeFormItemSecond), text: "Jahrgang des zweiten Kindes", answerFormat: kidsAgeAnswerFormat)
        
        var formItemThirdChild = ORKFormItem(identifier: String(describing:Identifier.personKidsAgeFormItemThird), text: "Jahrgang des vierten Kindes", answerFormat: kidsAgeAnswerFormat)
        
        var formItemFourthChild = ORKFormItem(identifier: String(describing:Identifier.personKidsAgeFormItemFourth), text: "Jahrgang des vierten Kindes", answerFormat: kidsAgeAnswerFormat)
        
        kidsAgeFormStep.formItems = [
            formItemFirstChild,
            formItemSecondChild,
            formItemThirdChild,
            formItemFourthChild
        ]
        
        // total days kids are in supervision (Fremdbetreuung)
        let kidsSupervisionFormStep = ORKFormStep(identifier: String(describing:Identifier.personKidsSupervisionFormStep))
        kidsSupervisionFormStep.title = "Wieviele Tage pro Woche sind die Kinder fremdbetreut?"
        kidsSupervisionFormStep.text = "durch Krippe, Hort, Nanny, etc. (0 = keine Fremdbetreuung)"
        
        let kidsSupervisionAnswerFormat = ORKNumericAnswerFormat.decimalAnswerFormat(withUnit: "Tage")
        
        formItemFirstChild = ORKFormItem(identifier: String(describing:Identifier.personKidsSupervisionItemFirst), text: "Ältestes Kind", answerFormat: kidsSupervisionAnswerFormat)
        
        formItemSecondChild = ORKFormItem(identifier: String(describing:Identifier.personKidsSupervisionItemSecond), text: "Zweitältestes Kind", answerFormat: kidsSupervisionAnswerFormat)
        
        formItemThirdChild = ORKFormItem(identifier: String(describing:Identifier.personKidsSupervisionItemThird), text: "Drittältestes Kind", answerFormat: kidsSupervisionAnswerFormat)
        
        formItemFourthChild = ORKFormItem(identifier: String(describing:Identifier.personKidsSupervisionItemFourth), text: "Viertältestes Kind", answerFormat: kidsSupervisionAnswerFormat)
        
        kidsSupervisionFormStep.formItems = [
            formItemFirstChild,
            formItemSecondChild,
            formItemThirdChild,
            formItemFourthChild
        ]
        
        
        // person in houshold
        let housholdAnswerFormat = ORKNumericAnswerFormat.decimalAnswerFormat(withUnit: "Personen")
        let housholdQuestion = ORKQuestionStep(identifier: String(describing:Identifier.personHoushold), title: "Wieviele Personen leben in Ihrem Haushalt?", answer: housholdAnswerFormat)
        
        // cars in houshold
        let carsFormQuestion = SurveyHelper.createSingleTextChoiceQuestionStep(ORKQuestionIdentifier: String(describing: Identifier.personCarsStep), QuestionTitle: "Wieviele Autos sind in Ihrem Haushalt vorhanden?", QuestionItems: standardQuestionsAndValues)
        
        // holiday trips
        let holidayFormQuestion = SurveyHelper.createSingleTextChoiceQuestionStep(ORKQuestionIdentifier: String(describing: Identifier.personHolidayStep), QuestionTitle: "Wie viele Ferienreisen haben Sie in den letzten 12 Monaten gemacht?", QuestionItems: standardQuestionsAndValues)
        
        // computer total
        let computerFormQuestion = SurveyHelper.createSingleTextChoiceQuestionStep(ORKQuestionIdentifier: String(describing: Identifier.personComputerStep), QuestionTitle: "Wie viele Computer (inkl. Laptops und Tablets) sind in Ihrem Haushalt insgesamt vorhanden?", QuestionItems: standardQuestionsAndValues)
        
        // bathrooms
        let bathroomFormQuestion = SurveyHelper.createSingleTextChoiceQuestionStep(ORKQuestionIdentifier: String(describing: Identifier.personBathroomStep), QuestionTitle: "Wie viele Badezimmer sind bei Ihnen zuhause vorhanden?", QuestionText: "Nur die Räume, in denen eine Dusche oder eine Badewanne sthet zählen. Separate WC nicht mitzählen.", QuestionItems: standardQuestionsAndValues)
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.personCompletionStep))
        completionStep.title = "Vielen Dank für den ersten Teil der Umfrage!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String (describing:Identifier.personTask), steps: [personInstructionStep, genderQuestion, yearQuestion, heightQuestion, weightQuestion, lifeFormQuestion, kidsStep,  totalKidsQuestion, kidsAgeFormStep, kidsSupervisionFormStep, housholdQuestion, carsFormQuestion, holidayFormQuestion, computerFormQuestion, bathroomFormQuestion, completionStep])
        
        // Build Navigation Rules for the kids
        let resultSelector: ORKResultSelector
        let predicateRule: ORKPredicateStepNavigationRule
        
        // From the personKidsStep step, go to either totalKidsQuestion or housholdQuestion
        resultSelector = ORKResultSelector(resultIdentifier: String(describing: Identifier.personKidsStep))
        let predicateAnswerType = ORKResultPredicate.predicateForBooleanQuestionResult(with: resultSelector, expectedAnswer: true)
        
        predicateRule = ORKPredicateStepNavigationRule(resultPredicates: [predicateAnswerType],                                                        destinationStepIdentifiers: [String(describing: Identifier.personKidsTotalStep)],                                                       defaultStepIdentifier: String(describing: Identifier.personHoushold),                                                       validateArrays: true)
        
        task.setNavigationRule(predicateRule, forTriggerStepIdentifier: String(describing: Identifier.personKidsStep))
        
        
        return task
    }
}
