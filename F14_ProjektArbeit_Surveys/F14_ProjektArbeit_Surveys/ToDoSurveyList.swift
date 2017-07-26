//
//  ToDoSurveyList.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import UIKit

class ToDoSurveyList {
    class var sharedInstance : ToDoSurveyList {
        struct Static {
            static let instance: ToDoSurveyList = ToDoSurveyList()
        }
        return Static.instance
    }
    
    fileprivate let ITEMS_KEY = "surveyTodoItems"
    
    func allItems() -> [TodoSurveyItem] {
        let todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        return items.map({
            let item = $0 as! [String:AnyObject]
            return TodoSurveyItem(deadline: item["deadline"] as! Date, surveyTitle: item["surveyTitle"] as! String, UUID: item["UUID"] as! String!)
        }).sorted(by: {(left: TodoSurveyItem, right:TodoSurveyItem) -> Bool in
            (left.deadline.compare(right.deadline) == .orderedAscending)
        })
    }

    
    func addItem(_ item: TodoSurveyItem) {
        // persist a representation of this todo item in UserDefaults
        var surveyTodoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        surveyTodoDictionary[item.UUID] = ["deadline": item.deadline, "title": item.surveyTitle, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
        UserDefaults.standard.set(surveyTodoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \"\(item.surveyTitle)\" Is Overdue" // text that will be displayed in the notification
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = item.deadline as Date // todo item due date (when notification will be fired) notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": item.surveyTitle, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
}
