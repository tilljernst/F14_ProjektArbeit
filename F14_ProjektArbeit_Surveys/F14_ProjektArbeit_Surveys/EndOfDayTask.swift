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
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.blockD_EndOfDayInstructionStep))
        
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
        
        let relaxationFormItemNew = ORKFormItem(identifier: String(describing:Identifier.relaxationNew_Q9), text: "… lerne ich Neues dazu.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemMental = ORKFormItem(identifier: String(describing:Identifier.relaxationMental_Q10), text: "… suche ich nach geistigen Herausforderungen.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemChallenge = ORKFormItem(identifier: String(describing:Identifier.relaxationChallenge_Q11), text: "… tue ich Dinge, die mich fordern.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemHorizon = ORKFormItem(identifier: String(describing:Identifier.relaxationHorizon_Q12), text: "… unternehme ich etwas, um meinen Horizont zu erweitern.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemDecide = ORKFormItem(identifier: String(describing:Identifier.relaxationDecide_Q13), text: "… habe ich das Gefühl, selbst entscheiden zu können.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemActivity = ORKFormItem(identifier: String(describing:Identifier.relaxationActivity_Q14), text: "… bestimme ich meine Tätigkeiten selbst.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemTime = ORKFormItem(identifier: String(describing:Identifier.relaxationTime_Q15), text: "… bestimme ich selbst, wie ich meine Zeit verbringe.", answerFormat: relaxationAnswerFormat)
        
        let relaxationFormItemThings = ORKFormItem(identifier: String(describing:Identifier.relaxationThings_Q16), text: "… erledige ich Dinge, die ich will.", answerFormat: relaxationAnswerFormat)
        
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
        
        // Daily Hassles
        let dailyHasslesFormStep_set1 = ORKFormStep(identifier: String(describing:Identifier.dailyHasslesFormStep))
        dailyHasslesFormStep_set1.title = "Nachfolgend finden Sie eine Aufzählung von möglichen alltäglichen Situationen und daneben eine Skala, auf der Sie einschätzen können, wie sehr Sie dieses Ereignis am heutigen Tag belastet hat."
        dailyHasslesFormStep_set1.text = "Bitte entscheiden Sie sich für eine Antwortoptionen für das Ereignis '… ist nicht aufgetreten' bis '… war unerträglich'"
        
        let dailyHasslesTextChoices : [ORKTextChoice] = [ORKTextChoice(text: "… ist nicht aufgetreten", value: 1 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… ist aufgetreten, hat Sie aber nicht belastet", value: 2 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… hat Sie sehr wenig belastet", value: 3 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… hat Sie ein wenig belastet", value: 4 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… hat Sie mässig belastet", value: 5 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… hat Sie stark belastet", value: 6 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… hat Sie sehr stark belastet", value: 7 as NSCoding & NSCopying & NSObjectProtocol), ORKTextChoice(text: "… war unerträglich", value: 8 as NSCoding & NSCopying & NSObjectProtocol)]
        
        let dailyHasslesAnswerFormat = ORKAnswerFormat.textScale(with: dailyHasslesTextChoices, defaultIndex: NSIntegerMax, vertical: false)
        
        let dailyHasslesTask_Q1 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesTask_Q1), text: "Ich habe eine Aufgabe nicht gut bewältigt.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPerformance_Q2 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPerformance_Q2), text: "Wegen anderer Personen habe ich schlechte Leistungen erbracht.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesWork_Q3 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesWork_Q3), text: "Ich dachte an meine unerledigten Arbeiten.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesRush_Q4 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesRush_Q4), text: "Ich musste hetzen, um einen Termin einzuhalten.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesDisturbed_Q5 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesDisturbed_Q5), text: "Ich wurde bei einer Aufgabe oder Arbeit gestört.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesMaster_Q6 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesMaster_Q6), text: "Ich musste etwas machen, was ich nicht richtig konnte.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesToEnd_Q7 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesToEnd_Q7), text: "Ich konnte eine Aufgabe nicht zu Ende führen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesMess_Q8 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesMess_Q8), text: "Ich war durcheinander.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesBadMouth_Q9 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesBadMouth_Q9), text: "Ich wurde kritisiert oder beschimpft.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesRespect_Q10 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesRespect_Q10), text: "Man hat mich nicht beachtet.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPublic_Q11 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPublic_Q11), text: "Ich musste öffentlich sprechen bzw. etwas vormachen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesUnfriendly_Q12 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesUnfriendly_Q12), text: "Ich wurde unfreundlich bedient.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesInterrupted_Q13 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesInterrupted_Q13), text: "Man hat mich beim Sprechen unterbrochen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPeople_Q14 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPeople_Q14), text: "Obwohl ich nicht wollte, musste ich mit Leuten zusammen sein.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPromise_Q15 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPromise_Q15), text: "Jemand hat ein Versprechen gebrochen/mich versetzt.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesCompetition_Q16 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesCompetition_Q16), text: "Ich stand in Konkurrenz zu jemandem.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesGlare_Q17 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesGlare_Q17), text: "Ich wurde angestarrt.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesNotHeard_Q18 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesNotHeard_Q18), text: "Jemand, an dem mir liegt, hat nichts von sich hören lassen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesDistrust_Q20 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesDistrust_Q20), text: "Ich wurde missverstanden.", answerFormat: dailyHasslesAnswerFormat)
        
        dailyHasslesFormStep_set1.formItems = [
            dailyHasslesTask_Q1,
            dailyHasslesPerformance_Q2,
            dailyHasslesWork_Q3,
            dailyHasslesRush_Q4,
            dailyHasslesDisturbed_Q5,
            dailyHasslesMaster_Q6,
            dailyHasslesToEnd_Q7,
            dailyHasslesMess_Q8,
            dailyHasslesBadMouth_Q9,
            dailyHasslesRespect_Q10,
            dailyHasslesPublic_Q11,
            dailyHasslesUnfriendly_Q12,
            dailyHasslesInterrupted_Q13,
            dailyHasslesPeople_Q14,
            dailyHasslesPromise_Q15,
            dailyHasslesCompetition_Q16,
            dailyHasslesGlare_Q17,
            dailyHasslesNotHeard_Q18,
            dailyHasslesDistrust_Q20
        ]
        
        let dailyHasslesFormStep_set2 = ORKFormStep(identifier: String(describing:Identifier.dailyHasslesFormStep))
        dailyHasslesFormStep_set2.title = "... Fortsetzung:"
        
        let dailyHasslesEmbarassed_Q21 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesEmbarassed_Q21), text: "Man machte mich verlegen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesForget_Q23 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesForget_Q23), text: "Ich habe etwas vergessen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesIllness_Q24 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesIllness_Q24), text: "Ich hatte Angst vor Krankheit.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPhysical_Q25 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPhysical_Q25), text: "Mir ging es körperlich nicht gut bzw. ich war krank.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesBorrow_Q26 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesBorrow_Q26), text: "Jemand hat sich etwas ausgeliehen, ohne mich zu fragen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesBroken_Q27 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesBroken_Q27), text: "Mir ist etwas kaputt gemacht worden.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesMishap_Q28 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesMishap_Q28), text: "Ich hatte einen kleinen Unfall (mir ist etwas zerbrochen,ein Kleidungsstück wurde zerrissen etc.).", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesFuture_Q29 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesFuture_Q29), text: "Ich dachte an die Zukunft.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesFood_Q30 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesFood_Q30), text: "Lebensmittel oder Gegenstände meines persönlichen Bedarfs sind mir ausgegangen.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesArgument_Q31 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesArgument_Q31), text: "Ich hatte Streit mit meinem Partner/meiner Partnerin oder meinem Freund/meiner Freundin.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesQuarrel_Q32 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesQuarrel_Q32), text: "Ich hatte mit jemand anderem Streit.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesWaiting_Q33 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesWaiting_Q33), text: "Ich musste länger warten, als ich wollte.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesDisturbed_Q34 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesDisturbed_Q34), text: "Ich wurde beim Nachdenken oder Entspannen gestört.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesPress_Q35 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesPress_Q35), text: "Jemand hat sich vorgedrängt.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesSport_Q36 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesSport_Q36), text: "Ich war beim Sport/Spiel schlecht.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesWouldnt_Q37 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesWouldnt_Q37), text: "Ich habe etwas getan, was ich eigentlich nicht wollte.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesExecute_Q38 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesExecute_Q38), text: "Ich konnte nicht alles erledigen, was ich mir vorgenommen hatte.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesCar_Q39 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesCar_Q39), text: "Ich hatte mit dem Auto Probleme.", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesNervous_Q40 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesNervous_Q40), text: "Der Strassen-Verkehr hat mich nervös gemacht.", answerFormat: dailyHasslesAnswerFormat)
        
        dailyHasslesFormStep_set2.formItems = [
            dailyHasslesEmbarassed_Q21,
            dailyHasslesForget_Q23,
            dailyHasslesIllness_Q24,
            dailyHasslesPhysical_Q25,
            dailyHasslesBorrow_Q26,
            dailyHasslesBroken_Q27,
            dailyHasslesMishap_Q28,
            dailyHasslesFuture_Q29,
            dailyHasslesFood_Q30,
            dailyHasslesArgument_Q31,
            dailyHasslesQuarrel_Q32,
            dailyHasslesWaiting_Q33,
            dailyHasslesDisturbed_Q34,
            dailyHasslesPress_Q35,
            dailyHasslesSport_Q36,
            dailyHasslesWouldnt_Q37,
            dailyHasslesExecute_Q38,
            dailyHasslesCar_Q39,
            dailyHasslesNervous_Q40
        ]
        
        let dailyHasslesFormStep_set3 = ORKFormStep(identifier: String(describing:Identifier.dailyHasslesFormStep))
        dailyHasslesFormStep_set3.title = "... Fortsetzung:"
        
        let dailyHasslesTrouble_Q41 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesTrouble_Q41), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesStore_Q42 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesStore_Q42), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesRelocate_Q43 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesRelocate_Q43), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesWeather_Q44 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesWeather_Q44), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesSpending_Q45 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesSpending_Q45), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesAuthority_Q46 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesAuthority_Q46), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesMessage_Q47 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesMessage_Q47), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesExternal_Q48 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesExternal_Q48), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesDrastic_Q49 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesDrastic_Q49), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesBadTempered_Q50 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesBadTempered_Q50), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesMissunderstanding_Q51 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesMissunderstanding_Q51), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesSorrow_Q52 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesSorrow_Q52), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesDanger_Q53 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesDanger_Q53), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesBadHabit_Q54 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesBadHabit_Q54), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesKids_Q55 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesKids_Q55), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        let dailyHasslesLate_Q56 = ORKFormItem(identifier: String(describing:Identifier.dailyHasslesLate_Q56), text: "", answerFormat: dailyHasslesAnswerFormat)
        
        dailyHasslesFormStep_set3.formItems = [
            dailyHasslesTrouble_Q41,
            dailyHasslesStore_Q42,
            dailyHasslesRelocate_Q43,
            dailyHasslesWeather_Q44,
            dailyHasslesSpending_Q45,
            dailyHasslesAuthority_Q46,
            dailyHasslesMessage_Q47,
            dailyHasslesExternal_Q48,
            dailyHasslesDrastic_Q49,
            dailyHasslesBadTempered_Q50,
            dailyHasslesMissunderstanding_Q51,
            dailyHasslesSorrow_Q52,
            dailyHasslesDanger_Q53,
            dailyHasslesBadHabit_Q54,
            dailyHasslesKids_Q55,
            dailyHasslesLate_Q56
        ]
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.blockD_EndOfDayCompletionStep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.blockD_EndOfDayTask), steps: [instructionStep, consumptionFormStep, technoStressFormStep, hedonismFormStep, relaxationFormStep, dailyHasslesFormStep_set1, dailyHasslesFormStep_set2, dailyHasslesFormStep_set3, completionStep])
        
        return task
    }
}
