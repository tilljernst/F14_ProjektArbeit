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
import ResearchKit

class ToDoSurveyList {
    class var sharedInstance : ToDoSurveyList {
        struct Static {
            static let instance: ToDoSurveyList = ToDoSurveyList()
        }
        return Static.instance
    }
    
    let ITEMS_KEY = "surveyTodoItems"
    
    func getItemsKey() -> String{
        return ITEMS_KEY
    }
    
    
    func allItems() -> [TodoSurveyItem] {
        let todoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values)
        return items.map({
            let item = $0 as! [String:AnyObject]
            let surveyTaskId = SurveyTaskId(rawValue: item["surveyTaskId"] as! Int)
            return TodoSurveyItem(deadline: item["deadline"] as! NSDate, surveyTitle: item["surveyTitle"] as! String, UUID: item["UUID"] as! String!, surveyTaskId: surveyTaskId!)
        }).sorted(by: {(left: TodoSurveyItem, right:TodoSurveyItem) -> Bool in
            (left.deadline.compare(right.deadline as Date) == .orderedAscending)
        })
    }

    
    func addItem(_ item: TodoSurveyItem) {
        // persist a representation of this todo item in UserDefaults
        var surveyTodoDictionary = UserDefaults.standard.dictionary(forKey: ITEMS_KEY) ?? Dictionary() // if todoItems hasn't been set in user defaults, initialize todoDictionary to an empty dictionary using nil-coalescing operator (??)
        surveyTodoDictionary[item.UUID] = ["deadline": item.deadline, "surveyTitle": item.surveyTitle, "UUID": item.UUID, "surveyTaskId": item.surveyTaskId.rawValue] // store NSData representation of todo item in dictionary with UUID as key
        UserDefaults.standard.set(surveyTodoDictionary, forKey: ITEMS_KEY) // save/overwrite todo item list
        
        // create a corresponding local notification, based on 
        if #available(iOS 10.0, *) {
            // configure the content of the trigger
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: item.surveyTitle, arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Umfrage \"\(item.surveyTitle)\" ist parat zum ausfüllen!",                                                                 arguments: nil)
            content.sound = UNNotificationSound.default()
            
            // Configure the trigger for a calendar notification trigger
            var dateComponents = DateComponents()
            let cal = NSCalendar.current
            dateComponents.year = cal.component(.year, from: item.deadline as Date)
            dateComponents.month = cal.component(.month, from: item.deadline as Date)
            dateComponents.day = cal.component(.day, from: item.deadline as Date)
            dateComponents.hour = cal.component(.hour, from: item.deadline as Date)
            dateComponents.minute = cal.component(.minute, from: item.deadline as Date)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
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
            notification.alertBody = "Umfrage \"\(item.surveyTitle)\" ist parat zum ausfüllen!" // text that will be displayed in the notification
            notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
            notification.alertTitle = item.surveyTitle
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
