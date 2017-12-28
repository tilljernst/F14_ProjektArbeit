//
//  ToDoSurveyTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 28.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import ResearchKit


public enum SurveyTaskId: Int {
    case blockA_personalData = 0
    case blockB_equipmentUsed
    case blockC_fitnessTest
    case blockD_endOfDay
    case blockE_sleepQuality
    case defaultTask
}

class ToDoSurveyTask {
    class var sharedInstance : ToDoSurveyTask {
        struct Static {
            static let instance: ToDoSurveyTask = ToDoSurveyTask()
        }
        return Static.instance
    }
    
    
    func getTaskBasedOnId(taskId:SurveyTaskId) -> ORKTask {
        switch taskId {
        case .blockA_personalData:
            return personalDataTask()
        case .blockB_equipmentUsed:
            return equipmentUsedTask()
        case .blockC_fitnessTest:
            return fitnessTask()
        case .blockD_endOfDay:
            return endOfDayTask()
        case .blockE_sleepQuality:
            return sleepQualityTask()
        default:
            return defaultTask()
        }
    }
    
    func getOrkIdentifierBasedOnId(taskId:SurveyTaskId) -> String {
        switch taskId {
        case .blockA_personalData:
            return String(describing:Identifier.personTask)
        case .blockB_equipmentUsed:
            return String(describing:Identifier.equipmentTask)
        case .blockC_fitnessTest:
            return String(describing:Identifier.fitnessTask)
        case .blockD_endOfDay:
            return String(describing:Identifier.endOfDayTask)
        case .blockE_sleepQuality:
            return String(describing:Identifier.sleepTask)
        default:
            return String(describing:Identifier.defaultTask)
        }
    }
    
    func getSurveyTitle (taskId:SurveyTaskId) -> String {
        switch taskId {
        case .blockA_personalData:
            return "Block A - Angaben zur Person"
        case .blockB_equipmentUsed:
            return "Block B - Ausgeführte Tätigkeiten"
        case .blockC_fitnessTest:
            return "Block C - Fitnesstest"
        case .blockD_endOfDay:
            return "Block D - Tagesendetest"
        case .blockE_sleepQuality:
            return "Block E - Schlafqualität"
        default:
            return "Default Task"
        }
    }
}

