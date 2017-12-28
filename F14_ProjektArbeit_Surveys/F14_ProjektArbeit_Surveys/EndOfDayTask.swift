//
//  FitnessTestTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 01.08.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

extension ToDoSurveyTask{
    /**
     This task is available in survey Block A and collects personal data
     */
    func endOfDayTask() -> ORKTask {
        // Intro step
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.endOfDayInstructionStep))
        
        instructionStep.title = ToDoSurveyTask.sharedInstance.getSurveyTitle(taskId: SurveyTaskId.blockD_endOfDay)
        //instructionStep.text = "Text:"
        
        // Konsum Substanzen
        let consumptionFormStep = ORKFormStep(identifier: String(describing:Identifier.consumptionFormStep))
        consumptionFormStep.title = "Anschliessend ein paar Fragen zum Konsum verschiedener Substanzen am heutigen Tag:"
        
        var stepAnswerFormatUnit = NSLocalizedString("Zigaretten", comment: "")
        let consumptionAnswerFormatZigaretten = ORKAnswerFormat.decimalAnswerFormat(withUnit: stepAnswerFormatUnit)
        
        let formItemZigaretten = ORKFormItem(identifier: String(describing:Identifier.consumptionZigaretten), text: "Wie viele Zigaretten haben Sie heute geraucht? (0 = keine)", answerFormat: consumptionAnswerFormatZigaretten)
        formItemZigaretten.placeholder = "0"
        
        stepAnswerFormatUnit = NSLocalizedString("alkoholische Getränke", comment: "")
        let consumptionAnswerFormatAlcohol = ORKAnswerFormat.decimalAnswerFormat(withUnit: stepAnswerFormatUnit)
        
        let formItemAlkohol = ORKFormItem(identifier: String(describing:Identifier.consumptionAlkohol), text: "Wie viele alkoholische Getränke haben Sie heute getrunken? (0 = keine) Beispiele für ein alkoholisches Getränk: 3,3dl Bier | 1dl Wein | 8cl Sherry oder Likör | 4cl Spirituosen oder Schnapps", answerFormat: consumptionAnswerFormatAlcohol)
        formItemAlkohol.placeholder = "0"
        
        stepAnswerFormatUnit = NSLocalizedString("Tassen", comment: "")
        let consumptionAnswerFormatKaffee = ORKAnswerFormat.decimalAnswerFormat(withUnit: stepAnswerFormatUnit)
        
        let formItemKaffee = ORKFormItem(identifier: String(describing:Identifier.consumptionKaffee), text: "Wie viele Tassen Kaffee (z.B Espresso / Cafe creme etc.) haben Sie heute getrunken?", answerFormat: consumptionAnswerFormatKaffee)
        formItemKaffee.placeholder = "0"
        
        consumptionFormStep.formItems = [
            formItemZigaretten,
            formItemAlkohol,
            formItemKaffee
        ]
        
        // TechnoStress
        let technoStressFormStep = ORKFormStep(identifier: String(describing:Identifier.technoStressFormStep))
        technoStressFormStep.title = "Wenn Sie ihre Mediennutzung des heutigen Tags Revue passieren lassen. Wie empfinden Sie im Moment:"
        technoStressFormStep.text = "Bitte entscheiden Sie sich für eine Antwortoptionen von 'stimme ich gar nicht zu' bis 'stimme ich voll und ganz zu'"
        
        let textChoices : [ORKTextChoice] = [ORKTextChoice(text: "stimme ich gar nicht zu", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich eher nicht zu", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "teils / teils", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich eher zu", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich voll und ganz zu", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
        
        let step5AnswerFormat = ORKAnswerFormat.textScale(with: textChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let technoStressFormItemTimepressure = ORKFormItem(identifier: String(describing:Identifier.technoStressTimePressure), text: "Die Unmittelbarkeit / Direktheit von bestimmten Medien löste bei mir Zeitdruck aus", answerFormat: step5AnswerFormat)
        
        
        technoStressFormStep.formItems = [
            technoStressFormItemTimepressure
        ]
        
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.endOfDayCompletionStep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.endOfDayTask), steps: [instructionStep, consumptionFormStep, technoStressFormStep, completionStep])
        
        return task
    }
}
