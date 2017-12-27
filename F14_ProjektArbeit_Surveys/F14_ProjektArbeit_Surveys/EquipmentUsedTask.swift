//
//  EquipmentUsedTask.swift
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
    func equipmentUsedTask() -> ORKTask {
        // Intro step
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.equipmentInstructionStep))
        
        instructionStep.title = ToDoSurveyTask.sharedInstance.getSurveyTitle(taskId: SurveyTaskId.blockB_equipmentUsed)
        instructionStep.text = "Bitte erfassen Sie verschiedene Tätigkeiten, die Sie während des Tages ausüben, so exakt wie möglich. Sie werden von der Befragungs-App im Folgenden alle vier Stunden aufgefordert, ihre verschiedene Tätigkeiten der letzten vier Stunden zu protokollieren."
        
        // Geräte
        let equipmentFormStep = ORKFormStep(identifier: String(describing:Identifier.equipmentFormStep))
        equipmentFormStep.title = "Welche der unten aufgeführten Geräte haben sie in den letzten vier Stunden beruflich oder privat genutzt? (Mehrere Antworten möglich)"
        
        let equipmentTextChoices = [
            ORKTextChoice(text: "beruflich genutzt", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "privat genutzt", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "nicht genutzt", value: 2 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let equipmentAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .multipleChoice, textChoices: equipmentTextChoices)
        
        let formItemSmartphone = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemSmartphone), text: "Smartphone", answerFormat: equipmentAnswerFormat)
        
        let formItemTv = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemTv), text: "TV", answerFormat: equipmentAnswerFormat)
        
        let formItemDesktop = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemDesktop), text: "Desktop Computer", answerFormat: equipmentAnswerFormat)
        
        let formItemTablet = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemTablet), text: "Tablet", answerFormat: equipmentAnswerFormat)
        
        let formItemRadio = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemRadio), text: "Radio", answerFormat: equipmentAnswerFormat)
        
        let formItemVideo = ORKFormItem(identifier: String(describing:Identifier.equipmentFormItemVideogame), text: "Videogame Konsole (stationär oder mobil)", answerFormat: equipmentAnswerFormat)
        
        equipmentFormStep.formItems = [
            formItemSmartphone,
            formItemTv,
            formItemDesktop,
            formItemTablet,
            formItemRadio,
            formItemVideo
        ]
        
        // Tätigkeiten
        let operationFormStep = ORKFormStep(identifier: String(describing:Identifier.operationFormStep))
        operationFormStep.title = "Welche der folgenden Tätigkeiten haben sie während der letzten vier Stunden ausgeführt?"
        
        let operationAnswerFormat = ORKBooleanAnswerFormat()
        
        let formItemTvWatching = ORKFormItem(identifier: String(describing:Identifier.operationFormItemTv), text: "TV-Sendung schauen", answerFormat: operationAnswerFormat)
        
        let formItemRadiolistening = ORKFormItem(identifier: String(describing:Identifier.operationFormItemRadio), text: "Radio Sendung hören", answerFormat: operationAnswerFormat)
        
        let formItemVideogame = ORKFormItem(identifier: String(describing:Identifier.operationFormItemVideogame), text: "Videogame spielen", answerFormat: operationAnswerFormat)

        let formItemMusic = ORKFormItem(identifier: String(describing:Identifier.operationFormItemMusic), text: "Musik hören", answerFormat: operationAnswerFormat)

        let formItemSocialNetwork = ORKFormItem(identifier: String(describing:Identifier.operationFormItemSocialNetwork), text: "Soziale Netzwerke besuchen", answerFormat: operationAnswerFormat)
        
        let formItemYoutube = ORKFormItem(identifier: String(describing:Identifier.operationFormItemYoutube), text: "Videoclips schauen (z.B. YouTube)", answerFormat: operationAnswerFormat)
        
        let formItemEmail = ORKFormItem(identifier: String(describing:Identifier.operationFormItemEmail), text: "E-Mails abgragen", answerFormat: operationAnswerFormat)
        
        let formItemOffice = ORKFormItem(identifier: String(describing:Identifier.operationFormItemOffice), text: "Office Software nutzen (z.B. Word, Excel, etc.)", answerFormat: operationAnswerFormat)
        
        let formItemGraphic = ORKFormItem(identifier: String(describing:Identifier.operationFormItemGrafic), text: "Grafiksoftware butzen (z.B. Adobe Photoshop, etc.)", answerFormat: operationAnswerFormat)
        
        let formItemInternetInfo = ORKFormItem(identifier: String(describing:Identifier.operationFormItemInternetInfo), text: "Im Internet gezielt nach Informationen suchen", answerFormat: operationAnswerFormat)
        
        let formItemInternetSurfing = ORKFormItem(identifier: String(describing:Identifier.operationFormItemInternetSurfing), text: "Im Internet ziellos drauflos surfen", answerFormat: operationAnswerFormat)
        
        let formItemMessage = ORKFormItem(identifier: String(describing:Identifier.operationFormItemMessage), text: "Messages / Nachrichten verschicken und erhalten (z.B. WhatsApp)", answerFormat: operationAnswerFormat)
        
        let formItemFotos = ORKFormItem(identifier: String(describing:Identifier.operationFormItemFotos), text: "Fotos machen (mit Handy oder Kamera)", answerFormat: operationAnswerFormat)
        
        let formItemFace2Face = ORKFormItem(identifier: String(describing:Identifier.operationFormItemFace2Face), text: "mich im persönlichen Gespräch (face-to-face) mit anderen Personen unterhalten (auch in Sitzungen)", answerFormat: operationAnswerFormat)
        
        let formItemOutdoor = ORKFormItem(identifier: String(describing:Identifier.operationFormItemOutdoor), text: "mich im Freuen bewegen (z.B. spazieren)", answerFormat: operationAnswerFormat)
        
        let formItemSport = ORKFormItem(identifier: String(describing:Identifier.operationFormItemSport), text: "Sport treiben", answerFormat: operationAnswerFormat)
        
        let formItemHobby = ORKFormItem(identifier: String(describing:Identifier.operationFormItemHobby), text: "Hobbys nachgehen (z.B. kreativ tätig sein, etc.)", answerFormat: operationAnswerFormat)
        
        let formItemCinema = ORKFormItem(identifier: String(describing:Identifier.operationFormItemCinema), text: "ins Kino gehen", answerFormat: operationAnswerFormat)
        
        operationFormStep.formItems = [
            formItemTvWatching,
            formItemRadiolistening,
            formItemVideogame,
            formItemMusic,
            formItemSocialNetwork,
            formItemYoutube,
            formItemEmail,
            formItemOffice,
            formItemGraphic,
            formItemInternetInfo,
            formItemInternetSurfing,
            formItemMessage,
            formItemFotos,
            formItemFace2Face,
            formItemOutdoor,
            formItemSport,
            formItemHobby,
            formItemCinema
        ]
        
        // Tätigkeiten letzten vier Stunden
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.equipmentCompletionStep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.equipmentTask), steps: [instructionStep, equipmentFormStep, operationFormStep, completionStep])
        
        return task
    }
}
