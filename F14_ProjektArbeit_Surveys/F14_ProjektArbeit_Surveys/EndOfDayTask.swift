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
        
        let formItemZigaretten = ORKFormItem(identifier: String(describing:Identifier.consumptionZigaretten_Q1), text: "Wie viele Zigaretten haben Sie heute geraucht? (0 = keine)", answerFormat: consumptionAnswerFormatZigaretten)
        formItemZigaretten.placeholder = "0"
        
        stepAnswerFormatUnit = NSLocalizedString("alkoholische Getränke", comment: "")
        let consumptionAnswerFormatAlcohol = ORKAnswerFormat.decimalAnswerFormat(withUnit: stepAnswerFormatUnit)
        
        let formItemAlkohol = ORKFormItem(identifier: String(describing:Identifier.consumptionAlkohol_Q2), text: "Wie viele alkoholische Getränke haben Sie heute getrunken? (0 = keine) Beispiele für ein alkoholisches Getränk: 3,3dl Bier | 1dl Wein | 8cl Sherry oder Likör | 4cl Spirituosen oder Schnapps", answerFormat: consumptionAnswerFormatAlcohol)
        formItemAlkohol.placeholder = "0"
        
        stepAnswerFormatUnit = NSLocalizedString("Tassen", comment: "")
        let consumptionAnswerFormatKaffee = ORKAnswerFormat.decimalAnswerFormat(withUnit: stepAnswerFormatUnit)
        
        let formItemKaffee = ORKFormItem(identifier: String(describing:Identifier.consumptionKaffee_Q3), text: "Wie viele Tassen Kaffee (z.B Espresso / Cafe creme etc.) haben Sie heute getrunken?", answerFormat: consumptionAnswerFormatKaffee)
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
        
        let technoStressTextChoices : [ORKTextChoice] = [ORKTextChoice(text: "stimme ich gar nicht zu", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich eher nicht zu", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "teils / teils", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich eher zu", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "stimme ich voll und ganz zu", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
        
        let technoStressAnswerFormat = ORKAnswerFormat.textScale(with: technoStressTextChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let technoStressFormItemTimepressure = ORKFormItem(identifier: String(describing:Identifier.technoStressTimePressure_Q1), text: "Die Unmittelbarkeit / Direktheit von bestimmten Medien löste bei mir Zeitdruck aus.", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemWorkAdaption = ORKFormItem(identifier: String(describing:Identifier.technoStressWorkAdaption_Q2), text: "Ich war gezwungen, einige (Arbeits-)Gewohnheiten wegen einzelner Medien anzupassen (z.B. viele E-Mails).", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemComplexity = ORKFormItem(identifier: String(describing:Identifier.technoStressComplexity_Q3), text: "Ich hatte einen höheren Aufwand wegen der Komplexität und Schnelligkeit von einzelnen Medien.", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemFamily = ORKFormItem(identifier: String(describing:Identifier.technoStressFamily_Q4), text: "Wegen bestimmten Medien verbrachte ich weniger Zeit mit meinen Freunden oder meiner Familie.", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemEmail = ORKFormItem(identifier: String(describing:Identifier.technoStressEmail_Q5), text: "Ich musste aus beruflichen Gründen auch während meiner Freizeit medial in Kontakten mit meinem Arbeitsumfeld bleiben (z.B. via Handy / E-Mail).", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemContinousChange = ORKFormItem(identifier: String(describing:Identifier.technoStressContinousChange_Q7), text: "Durch den ständigen Wandel bei einzelnen medialen Anwendungen, musste ich mich fortlaufend anpassen.", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemChangingApps = ORKFormItem(identifier: String(describing:Identifier.technoStressChangingApps_Q8), text: "Die von mir eingesetzten Apps und Anwendungen für die Mediennutzung ändern sich fortlaufend.", answerFormat: technoStressAnswerFormat)
        
        let technoStressFormItemUpgrade = ORKFormItem(identifier: String(describing:Identifier.technoStressUpgrade_Q9), text: "Ich musste durch Upgrades von Medien-Anwendungen auf dem Laufenden bleiben.", answerFormat: technoStressAnswerFormat)
        
        technoStressFormStep.formItems = [
            technoStressFormItemTimepressure,
            technoStressFormItemWorkAdaption,
            technoStressFormItemComplexity,
            technoStressFormItemFamily,
            technoStressFormItemEmail,
            technoStressFormItemContinousChange,
            technoStressFormItemChangingApps,
            technoStressFormItemUpgrade
        ]
        
        // Hedonismus
        let hedonismFormStep = ORKFormStep(identifier: String(describing:Identifier.hedonismFormStep))
        hedonismFormStep.title = "Wenn Sie ihre Mediennutzung des heutigen Tags Revue passieren lassen. Wie empfinden Sie im Moment:"
        hedonismFormStep.text = "Bitte entscheiden Sie sich für eine Antwortoptionen von 'stimme ich gar nicht zu' bis 'stimme ich voll und ganz zu'"
        
        // answer format and textchoices taken from the techno stress questions above
        
        let hedonismFormItemEntertainment = ORKFormItem(identifier: String(describing:Identifier.hedonismEntertainment_Q1), text: "Alles in allem fühle ich mich durch die Mediennutzung am heutigen Tag gut unterhalten.", answerFormat: technoStressAnswerFormat)
        
        let hedonismFormItemFun = ORKFormItem(identifier: String(describing:Identifier.hedonismFun_Q2), text: "Alles in allem hatte ich durch die Nutzung von Medien am heutigen Tag Spass.", answerFormat: technoStressAnswerFormat)
        
        let hedonismFormItemJoyful = ORKFormItem(identifier: String(describing:Identifier.hedonismJoyful_Q3), text: "Alles in allem kann ich die heutige Mediennutzung als freudvoll bezeichnen.", answerFormat: technoStressAnswerFormat)
        
        hedonismFormStep.formItems = [
            hedonismFormItemEntertainment,
            hedonismFormItemFun,
            hedonismFormItemJoyful
        ]
        
        // Entspannung, Kontrolle, Detachment, Mastery
        let relaxationFormStep = ORKFormStep(identifier: String(describing:Identifier.relaxationFormStep))
        relaxationFormStep.title = "Wenn Sie ihre Mediennutzung des heutigen Tags Revue passieren lassen. Wie ist ihre aktuelle Stimmung? In den letzten beiden Stunden…"
        relaxationFormStep.text = "Bitte entscheiden Sie sich für eine Antwortoptionen von 'trifft gar nicht zu' bis 'trifft völlig zu'"
        
        let relaxationTextChoices : [ORKTextChoice] = [ORKTextChoice(text: "trifft gar nicht zu", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft wenig zu", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft teils / teils zu", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft überwiegend zu", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "trifft völlig zu", value: 5 as NSCoding & NSCopying & NSObjectProtocol)]
        
        let relaxationAnswerFormat = ORKAnswerFormat.textScale(with: relaxationTextChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let relaxationFormItemWorkForget = ORKFormItem(identifier: String(describing:Identifier.relaxationWorkForget_Q1), text: "… habe ich meine Arbeit vergessen.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemWorkThink = ORKFormItem(identifier: String(describing:Identifier.relaxationWorkThink_Q2), text: "… denke ich überhaupt nicht an die Arbeit.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemWorkDistance = ORKFormItem(identifier: String(describing:Identifier.relaxationWorkDistance_Q3), text: "… gelingt es mir mich von meiner Arbeit zu distanzieren.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemWorkRequirement = ORKFormItem(identifier: String(describing:Identifier.relaxationWorkRequirement_Q4), text: "… gewinne ich Abstand zu meinen beruflichen Anforderungen.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemSoul = ORKFormItem(identifier: String(describing:Identifier.relaxationSoul_Q5), text: "… lasse ich meine Seele baumeln.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemEase = ORKFormItem(identifier: String(describing:Identifier.relaxationEase_Q6), text: "… unternehme ich Dinge, bei denen ich mich entspanne.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemRelax = ORKFormItem(identifier: String(describing:Identifier.relaxationRelax_Q7), text: "… nutze ich die Zeit zum relaxen.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemLeisure = ORKFormItem(identifier: String(describing:Identifier.relaxationLeisure_Q8), text: "… nehme ich mir Zeit zur Musse.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemNew = ORKFormItem(identifier: String(describing:Identifier.relaxationNew_Q10), text: "… lerne ich Neues dazu.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemMental = ORKFormItem(identifier: String(describing:Identifier.relaxationMental_Q11), text: "… suche ich nach geistigen Herausforderungen.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemChallenge = ORKFormItem(identifier: String(describing:Identifier.relaxationChallenge_Q12), text: "… tue ich Dinge, die mich fordern.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemHorizon = ORKFormItem(identifier: String(describing:Identifier.relaxationHorizon_Q13), text: "… unternehme ich etwas, um meinen Horizont zu erweitern.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemDecide = ORKFormItem(identifier: String(describing:Identifier.relaxationDecide_Q14), text: "… habe ich das Gefühl, selbst entscheiden zu können.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemActivity = ORKFormItem(identifier: String(describing:Identifier.relaxationActivity_Q15), text: "… bestimme ich meine Tätigkeiten selbst.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemTime = ORKFormItem(identifier: String(describing:Identifier.relaxationTime_Q16), text: "… bestimme ich selbst, wie ich meine Zeit verbringe.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemThings = ORKFormItem(identifier: String(describing:Identifier.relaxationThings_Q17), text: "… erledige ich Dinge, die ich will.", answerFormat: relaxationAnswerFormat)
        
        relaxationFormStep.formItems = [
            relaxationFormItemWorkForget,
            relaxationFormItemWorkThink,
            relaxationFormItemWorkDistance,
            relaxationFormItemWorkRequirement,
            relaxationFormItemSoul,
            relaxationFormItemEase,
            relaxationFormItemRelax,
            relaxationFormItemLeisure,
            relaxationFormItemNew,
            relaxationFormItemMental,
            relaxationFormItemChallenge,
            relaxationFormItemHorizon,
            relaxationFormItemDecide,
            relaxationFormItemActivity,
            relaxationFormItemTime,
            relaxationFormItemThings
        ]
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.endOfDayCompletionStep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.endOfDayTask), steps: [instructionStep, consumptionFormStep, technoStressFormStep, hedonismFormStep, relaxationFormStep, completionStep])
        
        return task
    }
}
