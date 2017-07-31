//
//  ToDoSurveyListTest.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 31.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import XCTest
import UserNotifications
@testable import F14_ProjektArbeit_Surveys

class ToDoSurveyListTest: XCTestCase {
    
    let toDoSurveyList = ToDoSurveyList()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddItem(){
        let uuId = UUID().uuidString
        var itemAdded = false
        // add item
        let todoItem = TodoSurveyItem(deadline: NSDate(), surveyTitle: "test item created in UnitTest func 'testAddItem'", UUID: uuId, surveyTaskId: SurveyTaskId.defaultTask)
        toDoSurveyList.addItem(todoItem)
        // check, if item is in UserDefaults
        let userDefaultsItems = UserDefaults.standard.dictionary(forKey: toDoSurveyList.getItemsKey())
        XCTAssertNotNil(userDefaultsItems?.index(forKey: uuId), "item is in user defaults")
        // check, if item is in LocalNotification
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { (notifications) in
                print("notifications.count", notifications.count)
                for notification in notifications{
                    if(notification.identifier == uuId){
                        itemAdded = true
                    }
                }
            })
            XCTAssertTrue(itemAdded)
        } else {
            let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
            
            guard scheduledNotifications != nil else {
                XCTAssertNil(scheduledNotifications)
                return
            }
            for notification in scheduledNotifications! { // loop through notifications...
                if (notification.userInfo!["UUID"] as! String == uuId) {
                    itemAdded = true
                }
            }
            XCTAssertTrue(itemAdded)
        }
        toDoSurveyList.removeItem(todoItem)
    }
    
    func testRemoveItem(){
        let uuId = UUID().uuidString
        var removed = true
        // add item
        let todoItem = TodoSurveyItem(deadline: NSDate(), surveyTitle: "test item created in UnitTest func 'testRemoveItem'", UUID: uuId, surveyTaskId: SurveyTaskId.defaultTask)
        toDoSurveyList.addItem(todoItem)
        // remove item
        toDoSurveyList.removeItem(todoItem)
        // check if item is removed from UserDefaults
        let userDefaultsItems = UserDefaults.standard.dictionary(forKey: toDoSurveyList.getItemsKey())
        XCTAssertNil(userDefaultsItems?.index(forKey: uuId))
        // check if item is removed from LocalNotifications
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { (notifications) in
                print("notifications.count", notifications.count)
                for notification in notifications{
                    if(notification.identifier == uuId){
                        removed = false
                    }
                }
            })
            XCTAssertTrue(removed)
        } else {
            let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
            
            guard scheduledNotifications != nil else {
                XCTAssertNil(scheduledNotifications)
                return
            }
            for notification in scheduledNotifications! { // loop through notifications...
                if (notification.userInfo!["UUID"] as! String == uuId) {
                    removed = false
                }
            }
            XCTAssertTrue(removed)
        }
    }
    
    func testCleanUpToDoSurveyList() {
        let uuId = UUID().uuidString
        var listCleaned = true
        // add item
        let todoItem = TodoSurveyItem(deadline: NSDate(), surveyTitle: "test item created in UnitTest func 'testCleanUpToDoSurveyList'", UUID: uuId, surveyTaskId: SurveyTaskId.defaultTask)
        toDoSurveyList.addItem(todoItem)
        // clean up
        toDoSurveyList.cleanUpToDoSurveyList()
        //check if no item is in UserDefaults
        let userDefaultsItems = UserDefaults.standard.dictionary(forKey: toDoSurveyList.getItemsKey())
        XCTAssertNil(userDefaultsItems?.index(forKey: uuId))
        // check if no item is in LocalNotifications
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getPendingNotificationRequests(completionHandler: { (notifications) in
                print("notifications.count", notifications.count)
                if notifications.count > 0{
                    listCleaned = false
                }
            })
            center.getDeliveredNotifications(completionHandler: {
                (notifications) in
                if notifications.count > 0 {
                    listCleaned = false
                }
            })
            XCTAssertTrue(listCleaned)
        } else {
            let scheduledNotifications: [UILocalNotification]? = UIApplication.shared.scheduledLocalNotifications
            XCTAssertNil(scheduledNotifications)
        }
    }
}
