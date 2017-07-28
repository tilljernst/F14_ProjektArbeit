//
//  ToDoSurveyItem.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

struct TodoSurveyItem {
    var surveyTitle: String
    var deadline: NSDate
    var UUID: String
    var surveyTaskId: SurveyTaskId
    
    init(deadline: NSDate, surveyTitle: String, UUID: String, surveyTaskId: SurveyTaskId) {
        self.deadline = deadline
        self.surveyTitle = surveyTitle
        self.UUID = UUID
        self.surveyTaskId = surveyTaskId
    }
    
    var isOverdue: Bool {
        // Optionally, you can omit "ComparisonResult" and it will be inferred.
        return (NSDate().compare(self.deadline as Date) == ComparisonResult.orderedDescending) // deadline is earlier than current date
    }
}

