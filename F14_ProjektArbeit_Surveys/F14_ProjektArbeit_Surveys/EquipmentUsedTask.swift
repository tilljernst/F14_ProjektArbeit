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
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.blockB_equipmentInstructionStep))
        
        instructionStep.title = ToDoSurveyTask.sharedInstance.getSurveyTitle(taskId: SurveyTaskId.blockB_equipmentUsed)
        instructionStep.text = "Bitte erfassen Sie verschiedene Tätigkeiten, die Sie während des Tages ausüben, so exakt wie möglich. Sie werden von der Befragungs-App im Folgenden alle vier Stunden aufgefordert, ihre verschiedene Tätigkeiten der letzten vier Stunden zu protokollieren."
        
        // Geräte
        let equipmentFormStep = ORKFormStep(identifier: String(describing:Identifier.equipmentFormStep))
        equipmentFormStep.title = "Welche der unten aufgeführten Geräte haben sie in den letzten vier Stunden beruflich und/oder privat genutzt?"
        
        let equipmentTextChoices = [
            ORKTextChoice(text: "beruflich genutzt", value: 0 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "privat genutzt", value: 1 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "beruflich und privat genutzt", value: 2 as NSCoding & NSCopying & NSObjectProtocol),
            ORKTextChoice(text: "nicht genutzt", value: 3 as NSCoding & NSCopying & NSObjectProtocol)
        ]
        
        let equipmentAnswerFormat = ORKAnswerFormat.choiceAnswerFormat(with: .singleChoice, textChoices: equipmentTextChoices)
        
        let formItemSmartphone = ORKFormItem(identifier: String(describing:Identifier.equipmenSmartphone_Q1), text: "Smartphone", answerFormat: equipmentAnswerFormat)
        
        let formItemTv = ORKFormItem(identifier: String(describing:Identifier.equipmentTv_Q2), text: "TV", answerFormat: equipmentAnswerFormat)
        
        let formItemDesktop = ORKFormItem(identifier: String(describing:Identifier.equipmentDesktop_Q3), text: "Desktop Computer", answerFormat: equipmentAnswerFormat)
        
        let formItemTablet = ORKFormItem(identifier: String(describing:Identifier.equipmentTablet_Q4), text: "Tablet", answerFormat: equipmentAnswerFormat)
        
        let formItemRadio = ORKFormItem(identifier: String(describing:Identifier.equipmentRadio_Q5), text: "Radio", answerFormat: equipmentAnswerFormat)
        
        let formItemVideo = ORKFormItem(identifier: String(describing:Identifier.equipmentVideogame_Q6), text: "Videogame Konsole (stationär oder mobil)", answerFormat: equipmentAnswerFormat)
        
        equipmentFormStep.formItems = [
            formItemSmartphone,
            formItemTv,
            formItemDesktop,
            formItemTablet,
            formItemRadio,
            formItemVideo
        ]
        
        // Tätigkeiten
        let operationFormStep = ORKFormStep(identifier: String(describing:Identifier.mediaActivityFormStep))
        operationFormStep.title = "Wie lange haben Sie..."
        operationFormStep.text = "Welche der folgenden Tätigkeiten haben sie während der letzten vier Stunden ausgeführt und wie lange? Nicht ausgeführte Tätigkeit werden mit 0 Minuten angegeben."
        
        let operationQuestionStepAnswerFormatUnit = NSLocalizedString("Minuten", comment: "")
        let operationAnswerFormat = ORKAnswerFormat.decimalAnswerFormat(withUnit: operationQuestionStepAnswerFormatUnit)
        
        let formItemTvWatching = ORKFormItem(identifier: String(describing:Identifier.mediaActivityTv_Q1), text: "TV-Sendung schauen", answerFormat: operationAnswerFormat)
        formItemTvWatching.placeholder = "0"
        
        let formItemRadiolistening = ORKFormItem(identifier: String(describing:Identifier.mediaActivityRadio_Q2), text: "Radio Sendung hören", answerFormat: operationAnswerFormat)
        formItemRadiolistening.placeholder = "0"
        
        let formItemVideogame = ORKFormItem(identifier: String(describing:Identifier.mediaActivityVideogame_Q3), text: "Videogame spielen", answerFormat: operationAnswerFormat)
        formItemVideogame.placeholder = "0"
        
        let formItemMusic = ORKFormItem(identifier: String(describing:Identifier.mediaActivityMusic_Q4), text: "Musik hören", answerFormat: operationAnswerFormat)
        formItemMusic.placeholder = "0"
        
        let formItemSocialNetwork = ORKFormItem(identifier: String(describing:Identifier.mediaActivitySocialNetwork_Q5), text: "Soziale Netzwerke besuchen", answerFormat: operationAnswerFormat)
        formItemSocialNetwork.placeholder = "0"
        
        let formItemYoutube = ORKFormItem(identifier: String(describing:Identifier.mediaActivityYoutube_Q6), text: "Videoclips schauen (z.B. YouTube)", answerFormat: operationAnswerFormat)
        formItemYoutube.placeholder = "0"
        
        let formItemEmail = ORKFormItem(identifier: String(describing:Identifier.mediaActivityEmail_Q7), text: "E-Mails abgragen", answerFormat: operationAnswerFormat)
        formItemEmail.placeholder = "0"
        
        let formItemOffice = ORKFormItem(identifier: String(describing:Identifier.mediaActivityOffice_Q8), text: "Office Software nutzen (z.B. Word, Excel, etc.)", answerFormat: operationAnswerFormat)
        formItemOffice.placeholder = "0"
        
        let formItemGraphic = ORKFormItem(identifier: String(describing:Identifier.mediaActivityGrafic_Q9), text: "Grafiksoftware butzen (z.B. Adobe Photoshop, etc.)", answerFormat: operationAnswerFormat)
        formItemGraphic.placeholder = "0"
        
        let formItemInternetInfo = ORKFormItem(identifier: String(describing:Identifier.mediaActivityInternetInfo_Q10), text: "Im Internet gezielt nach Informationen suchen", answerFormat: operationAnswerFormat)
        formItemInternetInfo.placeholder = "0"
        
        let formItemInternetSurfing = ORKFormItem(identifier: String(describing:Identifier.mediaActivityInternetSurfing_Q11), text: "Im Internet ziellos drauflos surfen", answerFormat: operationAnswerFormat)
        formItemInternetSurfing.placeholder = "0"
        
        let formItemMessage = ORKFormItem(identifier: String(describing:Identifier.mediaActivityMessage_Q12), text: "Messages / Nachrichten verschicken und erhalten (z.B. WhatsApp)", answerFormat: operationAnswerFormat)
        formItemMessage.placeholder = "0"
        
        let formItemFotos = ORKFormItem(identifier: String(describing:Identifier.mediaActivityFotos_Q13), text: "Fotos machen (mit Handy oder Kamera)", answerFormat: operationAnswerFormat)
        formItemFotos.placeholder = "0"
        
        let formItemFace2Face = ORKFormItem(identifier: String(describing:Identifier.mediaActivityFace2Face_Q14), text: "mich im persönlichen Gespräch (face-to-face) mit anderen Personen unterhalten (auch in Sitzungen)", answerFormat: operationAnswerFormat)
        formItemFace2Face.placeholder = "0"
        
        let formItemOutdoor = ORKFormItem(identifier: String(describing:Identifier.mediaActivityOutdoor_Q15), text: "mich im Freuen bewegen (z.B. spazieren)", answerFormat: operationAnswerFormat)
        formItemOutdoor.placeholder = "0"
        
        let formItemSport = ORKFormItem(identifier: String(describing:Identifier.mediaActivitySport_Q16), text: "Sport treiben", answerFormat: operationAnswerFormat)
        formItemSport.placeholder = "0"
        
        let formItemHobby = ORKFormItem(identifier: String(describing:Identifier.mediaActivityHobby_Q17), text: "Hobbys nachgehen (z.B. kreativ tätig sein, etc.)", answerFormat: operationAnswerFormat)
        formItemHobby.placeholder = "0"
        
        let formItemCinema = ORKFormItem(identifier: String(describing:Identifier.mediaActivityCinema_Q18), text: "ins Kino gehen", answerFormat: operationAnswerFormat)
        formItemCinema.placeholder = "0"
        
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
        
        // Mediale Inhalte
        let medialContentFormStep = ORKFormStep(identifier: String(describing:Identifier.mediaContentFormStep))
        medialContentFormStep.title = "Welche Inhalte haben Sie konsumiert?"
        medialContentFormStep.text = "Nun noch zu einigen medialen Inhalten, die Sie während der letzten vier Stunden konsumiert haben. Bitte geben Sie in Stichworten an, welche Inhalte Sie konsumiert haben (z.B. TV-Sendungen, Filmgenres, Sänger, Bands etc.) Falls Sie kein medialen Inhalt konsumiert haben, lassen Sie das Feld leer."
        
        let medialContentAnswerFormat = ORKAnswerFormat.textAnswerFormat()
        medialContentAnswerFormat.multipleLines = false
        
        let formItemTvContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentTv_Q1), text: "... im TV?", answerFormat: medialContentAnswerFormat)
        formItemTvContent.placeholder  = "Stichworte (z.B. Sendungen)"
        
        let formItemRadioContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentRadio_Q2), text: "... im Radio?", answerFormat: medialContentAnswerFormat)
        formItemRadioContent.placeholder  = "Stichworte (z.B. Sendungen)"
        
        let formItemGamingContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentGaming_Q3), text: "... beim Gamen?", answerFormat: medialContentAnswerFormat)
        formItemGamingContent.placeholder  = "Stichworte (z.B. Genres)"
        
        let formItemMusicContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentMusic_Q4), text: "... beim Musikhören?", answerFormat: medialContentAnswerFormat)
        formItemMusicContent.placeholder  = "Stichworte (z.B. Genres, Bands)"
        
        let formItemSocialNetworkContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentSocialNetwork_Q5), text: "... beim Nutzen von sozialen Netzwerken?", answerFormat: medialContentAnswerFormat)
        formItemSocialNetworkContent.placeholder  = "Stichworte"
        
        let formItemVideoContent = ORKFormItem(identifier: String(describing:Identifier.mediaContentVideo_Q6), text: "...  beim Schauen von Videoclips (z.B. auf YouTube?", answerFormat: medialContentAnswerFormat)
        formItemVideoContent.placeholder  = "Stichworte (z.B. Genres)"
        
        medialContentFormStep.formItems = [
            formItemTvContent,
            formItemRadioContent,
            formItemGamingContent,
            formItemMusicContent,
            formItemSocialNetworkContent,
            formItemVideoContent
        ]
            
        
        // completion step
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.blockB_equipmentCompletionStep))
        completionStep.title = "Vielen Dank!"
        
        // create the task
        let task = ORKNavigableOrderedTask(identifier: String(describing:Identifier.blockB_equipmentTask), steps: [instructionStep, equipmentFormStep, operationFormStep, medialContentFormStep, completionStep])
        
        return task
    }
}
