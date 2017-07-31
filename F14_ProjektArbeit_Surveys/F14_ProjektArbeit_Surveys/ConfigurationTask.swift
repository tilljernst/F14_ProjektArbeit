//
//  ConfigurationTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

public var ConfigurationTask: ORKTask {
    let instStep = ORKInstructionStep(identifier: String(describing:Identifier.operationInstructionStep))
        
    instStep.title = "Konfiguration"
    instStep.text = "Heart Rate ID & Startdatum"
    instStep.detailText = "Im Folgenden werden Sie gebeten, die ID des Pulstrackers und das Startdatum für die Befragung einzugeben."
    
    // heart rate id
    let heartRateAnswerFormat = ORKAnswerFormat.textAnswerFormat(withMaximumLength: 12)
    heartRateAnswerFormat.multipleLines = false
    let heartRateIdStep = ORKQuestionStep(identifier: String(describing:Identifier.configurationHeartRateIdStep), title: "Bitte geben Sie die ID ihres Heart-Rate Monitors ein:", answer: heartRateAnswerFormat)
    heartRateIdStep.isOptional = false
    
    // start date
    let today = Date()
    let maximumDate = Calendar.current.date(byAdding: .day, value: 8, to: today)
    let startDateFormat =  ORKAnswerFormat.dateAnswerFormat()
//    let startDateFormat =  ORKAnswerFormat.dateAnswerFormat(withDefaultDate: today, minimumDate: today, maximumDate: maximumDate, calendar: NSCalendar.current)
    let startDateStep = ORKQuestionStep(identifier: String(describing:Identifier.configurationStartDateStep), title: "Bitte geben Sie den Tag ein, an dem Sie mit der Umfrage beginnen wollen:", answer: startDateFormat)
    startDateStep.isOptional = false
    
    // completion step
    let completionStep = ORKCompletionStep(identifier: "Die App ist nun konfiguriert.")
        completionStep.title = "Vielen Dank!"
        
    let task = ORKOrderedTask(identifier: String(describing:Identifier.configurationTask), steps: [instStep, heartRateIdStep, startDateStep, completionStep])
    
    return task
}
