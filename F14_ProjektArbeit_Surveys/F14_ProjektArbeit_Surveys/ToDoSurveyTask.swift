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
    case personalData = 0
    case equipmentUsed
    case equipmentOperated
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
//        let id = SurveyTaskId.RawValue(taskId)
//        let id = SurveyTaskListRow.personData
        
        switch taskId {
        case .personalData:
            return personalDataTask()
        case .equipmentUsed:
            return defaultTask()
        case .equipmentOperated:
            return defaultTask()
        default:
            return defaultTask()
        }
    }    
}

