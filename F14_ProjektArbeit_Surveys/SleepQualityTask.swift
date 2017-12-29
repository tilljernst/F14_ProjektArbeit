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
    func sleepQualityTask() -> ORKTask {
        // Intro step
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.blockE_sleepInstructionStep))
        
        instructionStep.title = ToDoSurveyTask.sharedInstance.getSurveyTitle(taskId: SurveyTaskId.blockE_sleepQuality)
        instructionStep.text = "Nun geht es gegen Abend zu. Bitte beantworten Sie ein paar Fragen zum Schlafes während der letzten Nacht und zu Ihrem Zustand während dieses Tages:"
        
        // Einschlafzeit
        let sleepQualityTimeAnswerFormat = ORKAnswerFormat.timeOfDayAnswerFormat()
        
        let sleepQualityFallAsleep_Q1 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityFallAsleep_Q1), title: "Wann sind Sie letzte Nacht eingeschlafen?", answer: sleepQualityTimeAnswerFormat)
        sleepQualityFallAsleep_Q1.text = "ca."
        
        
        // Aufwachzeit
        let sleepQualityWakeUp_Q2 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityWakeUp_Q2), title: "Wann sind Sie heute Morgen aufgewacht?", answer: sleepQualityTimeAnswerFormat)
        sleepQualityFallAsleep_Q1.text = "ca."

        // Schlafdauer
        let sleepQualityTextChoices : [ORKTextChoice] = [ORKTextChoice(text: "sehr kurz", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "kurz", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "normal", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "lang", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "sehr lang", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
        let sleepQualityScaleAnswerFormat = ORKAnswerFormat.textScale(with: sleepQualityTextChoices, defaultIndex: NSIntegerMax, vertical: true)
        
        let sleepQualityDuration_Q3 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityDuration_Q3), title: "War dies für Sie vergleichsweise..", answer: sleepQualityScaleAnswerFormat)
        
        // Im Bett bevor Licht gelöscht
        let sleepQualityDurationAnswerFormat = ORKAnswerFormat.timeIntervalAnswerFormat()
        
        let sleepQualityBeforeLightOut_Q4 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityBeforeLightOut_Q4), title: "Wie lange waren Sie abends im Bett, bevor Sie versuchten zu schlafen (Licht löschten)?", answer: sleepQualityDurationAnswerFormat)
        sleepQualityBeforeLightOut_Q4.text = "ca."
        
        // Dauer bis Schlaf
        let sleepQualityUntilSleep_Q5 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityUntilSleep_Q5), title: "Wie lange hat es anschließend gedauert, bis Sie einschliefen?", answer: sleepQualityDurationAnswerFormat)
        sleepQualityUntilSleep_Q5.text = "ca."
        
        // Vergleich
        let sleepQualityCompare_Q6 = ORKQuestionStep(identifier: String(describing:Identifier.sleepQualityCompare_Q6), title: "War dies für Sie vergleichsweise..", answer: sleepQualityScaleAnswerFormat)
        
        // Sleep Form
        let sleepQualityNightFormStep = ORKFormStep(identifier: String(describing:Identifier.sleepQualityFormStep))
        sleepQualityNightFormStep.title = ""
        
        let sleepQualityBoolAnswerFormat = ORKBooleanAnswerFormat()
        
        let sleepQualityNightQuality_Q1 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightQuality_Q1), text: "Konnten Sie letzte Nacht schlecht einschlafen?", answerFormat: sleepQualityBoolAnswerFormat)

        let sleepQualityNightFallback_Q2 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightFallback_Q2), text: "Sind Sie heute Moren zu früh aufgewacht und konnten nicht mehr einschlafen?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightSleep_Q3 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightSleep_Q3), text: "Haben Sie in der letzten Nacht gut geschlafen?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightTired_Q4 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightTired_Q4), text: "Waren Sie während des Tages teilweise sehr müde, dass Sie fast eingeschlafen wären?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightTrouble_Q5 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightTrouble_Q5), text: "Sind Sie während der letzten Nacht aufgewacht und hatten Mühe wieder einzuschlafen?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightNap_Q6 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightNap_Q6), text: "Haben Sie sich heute Nachmittag hingelegt und sind (fast) eingeschlafen?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightHappy_Q7 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightHappy_Q7), text: "Sind Sie zufrieden mit dem Schlaf der letzten Nacht?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightSleepy_Q8 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightSleepy_Q8), text: "Haben Sie sich während dem Tag müde oder schläfrig gefühlt?", answerFormat: sleepQualityBoolAnswerFormat)
        
        let sleepQualityNightNightmare_Q9 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityNightNightmare_Q9), text: "Hatten Sie Alpträume in der letzten Nacht?", answerFormat: sleepQualityBoolAnswerFormat)
        
        sleepQualityNightFormStep.formItems = [
            sleepQualityNightQuality_Q1,
            sleepQualityNightFallback_Q2,
            sleepQualityNightSleep_Q3,
            sleepQualityNightTired_Q4,
            sleepQualityNightTrouble_Q5,
            sleepQualityNightNap_Q6,
            sleepQualityNightHappy_Q7,
            sleepQualityNightSleepy_Q8,
            sleepQualityNightNightmare_Q9
        ]
        
        // Mental State
        let sleepQualityMentalStateFormStep = ORKFormStep(identifier: String(describing:Identifier.sleepQualityMentalStateFormStep))
        sleepQualityMentalStateFormStep.title = "Wie fühlen Sie sich jetzt im Moment?"
        
        let sleepQualityMentalStateTextChoices : [ORKTextChoice] = [ORKTextChoice(text: "trifft gar nicht zu", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft wenig zu", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft teils / teils zu", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft überwiegend  zu", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft völlig zu", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
        let sleepQualityMentalStateScaleAnswerFormat = ORKAnswerFormat.textScale(with: sleepQualityMentalStateTextChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let sleepQualityMentalStateStressed_Q1 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityMentalStateStressed_Q1), text: "… angespannt", answerFormat: sleepQualityMentalStateScaleAnswerFormat)
        
        let sleepQualityMentalStateFresh_Q2 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityMentalStateFresh_Q2), text: "… frisch", answerFormat: sleepQualityMentalStateScaleAnswerFormat)
        
        let sleepQualityMentalStateDepressed_Q3 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityMentalStateDepressed_Q3), text: "… bedrückt", answerFormat: sleepQualityMentalStateScaleAnswerFormat)
        
        let sleepQualityMentalStateRelaxed_Q4 = ORKFormItem(identifier: String(describing:Identifier.sleepQualityMentalStateRelaxed_Q4), text: "… erholt", answerFormat: sleepQualityMentalStateScaleAnswerFormat)
        
        sleepQualityMentalStateFormStep.formItems = [
            sleepQualityMentalStateStressed_Q1,
            sleepQualityMentalStateFresh_Q2,
            sleepQualityMentalStateDepressed_Q3,
            sleepQualityMentalStateRelaxed_Q4
        ]
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.blockE_sleepCompletionstep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.blockE_sleepTask), steps: [instructionStep, sleepQualityFallAsleep_Q1, sleepQualityWakeUp_Q2, sleepQualityDuration_Q3, sleepQualityBeforeLightOut_Q4, sleepQualityUntilSleep_Q5, sleepQualityCompare_Q6, sleepQualityNightFormStep, sleepQualityMentalStateFormStep, completionStep])
        
        return task
    }
}
