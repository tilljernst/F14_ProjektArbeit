//
//  ToDoSurveyList.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

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
            return TodoSurveyItem(deadline: item["deadline"] as! NSDate, surveyTitle: item["surveyTitle"] as! String, UUID: item["UUID"] as! String!)
        }).sorted(by: {(left: TodoSurveyItem, right:TodoSurveyItem) -> Bool in
            (left.deadline.compare(right.deadline as Date) == .orderedAscending)
        })
    }

    
    func addItem(_ item: TodoSurveyItem) {
        // persist a representation of this todo item in UserDefaults
        var surveyTodoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        surveyTodoDictionary[item.UUID] = ["deadline": item.deadline, "surveyTitle": item.surveyTitle, "UUID": item.UUID] // store NSData representation of todo item in dictionary with UUID as key
        UserDefaults.standard.set(surveyTodoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification, based on 
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Title of the notification", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Todo Item \"\(item.surveyTitle)\" Is Overdue",                                                                 arguments: nil)
            content.sound = UNNotificationSound.default()
            
            // tmp: Configure the trigger for 10s trigger
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20.0, repeats: false)
            
            // Create the request object.
            let notificationRequest = UNNotificationRequest(identifier: item.UUID, content: content, trigger: trigger)
            
            // Schedule the request.
            let center = UNUserNotificationCenter.current()
            center.add(notificationRequest) { (error : Error?) in
                if let theError = error {
                    print(theError.localizedDescription)
                } else {
                    print("notification '\(item.surveyTitle)' scheduled")
                }
            }
            
        } else {
            let notification = UILocalNotification()
            notification.alertBody = "Todo Item \"\(item.surveyTitle)\" Is Overdue" // text that will be displayed in the notification
            notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
            notification.alertTitle = "Reason for the alert"
            notification.fireDate = item.deadline as Date // todo item due date (when notification will be fired)
            notification.soundName = UILocalNotificationDefaultSoundName // play default sound
            notification.userInfo = ["surveyTitle": item.surveyTitle, "UUID": item.UUID] // assign a unique identifier to the notification so that we can retrieve it later
        
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    func removeItem(_ item: TodoSurveyItem){
        // remove item from UserDefaults
        if var todoItems = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) {
            todoItems.removeValue(forKey: item.UUID)
            UserDefaults.standard.set(todoItems, forKey: ITEMS_KEY) // save/overwrite todo item list
        }
        if #available(iOS 10.0, *) {
            // TODO: remove Notification
            // Schedule the request.
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [item.UUID])
        } else {
            let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
            guard scheduledNotifications != nil else {return} // Nothing to remove, so return
        
            for notification in scheduledNotifications! { // loop through notifications...
                if (notification.userInfo!["UUID"] as! String == item.UUID) { // ...and cancel the notification that corresponds to this TodoItem instance (matched by UUID)
                    UIApplication.shared.cancelLocalNotification(notification) // there should be a maximum of one match on UUID
                    break
                }
            }
        }
    }
    
    func cleanUpToDoSurveyList(){
        // remove items from UserDefault
        UserDefaults.standard.removeObject(forKey: ITEMS_KEY)
        
        if #available(iOS 10.0, *) {
            // Schedule the request.
            let center = UNUserNotificationCenter.current()
            center.removeAllPendingNotificationRequests()
            center.removeAllDeliveredNotifications()
        } else {
            let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
            guard scheduledNotifications != nil else {return} // Nothing to remove, so return
            
            for notification in scheduledNotifications! { // loop through notifications...
                UIApplication.shared.cancelLocalNotification(notification) // there should be a maximum of one match on UUID
            }
        }
    }
    
}
