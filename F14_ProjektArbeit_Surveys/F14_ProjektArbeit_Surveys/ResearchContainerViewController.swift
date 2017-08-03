//
//  ResearchContainerViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

/*
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import UIKit
import ResearchKit
import UserNotifications

class ResearchContainerViewController: UIViewController, HealthClientType {
    // MARK: HealthClientType
    
    var healthStore: HKHealthStore?
    var localNotificationsisGrantedAccess = false
    
    // MARK: Propertues
    
    var contentHidden = false {
        didSet {
            guard contentHidden != oldValue && isViewLoaded else { return }
            childViewControllers.first?.view.isHidden = contentHidden
        }
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Local Notification: Requesting Authorization to Interact with the User
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            
            center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
                self.localNotificationsisGrantedAccess = granted
                if granted{
                    print("user granted notifications")
                    self.registerLocalNotificationCategories()
                } else {
                    print(error ?? "got an error in request authorization for local notifications")
                    let alert = UIAlertController(title: "Notification Access", message: "In order to use this application, turn on notification permissions.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                    alert.addAction(alertAction)
                    self.present(alert , animated: true, completion: nil)
                }
            }
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        }

        
        // bereits Passcode erstellt -> Einführung ist gemacht
        if ORKPasscodeViewController.isPasscodeStoredInKeychain() {
            // prüfen, ob Konfigutation bereits vorgenommen
            if(UserDefaultHandler.sharedInstance.isUserConfigurationSet()){
                print("go to study")
                toStudy()
            }
            else{
                print("go to configuration")
                toConfiguration()
            }
        }
        else {
            print("go to onboarding")
            toOnboarding()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let healthStore = healthStore {
            segue.destination.injectHealthStore(healthStore)
        }
    }
    
    // MARK: Unwind segues
    
    @IBAction func unwindToStudy(_ segue: UIStoryboardSegue) {
        toStudy()
    }
    
    @IBAction func unwindToConfiguration(_ segue: UIStoryboardSegue) {
        toConfiguration()
    }
    
    @IBAction func unwindToWithdrawl(_ segue: UIStoryboardSegue) {
        toWithdrawl()
    }
    
    // MARK: Transitions
    
    func toOnboarding() {
        performSegue(withIdentifier: "toOnboarding", sender: self)
    }
    
    func toStudy() {
        performSegue(withIdentifier: "toStudy", sender: self)
    }
    
    func toConfiguration() {
        performSegue(withIdentifier: "toConfiguration", sender: self)
    }
    
    func toWithdrawl() {
        let viewController = WithdrawViewController()
        viewController.delegate = self
        
        present(viewController, animated: true, completion: nil)
    }
    
    
    // MARK: Local Notifications
    
    // local user notfications options
    func registerLocalNotificationCategories() {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            
            let snoozeAction = UNNotificationAction(identifier: "snooze", title: "In 10 Minuten nochmals erinnern...", options: [])
            let surveyAlarmCategory = UNNotificationCategory(identifier: "surveyAlarm.category", actions: [snoozeAction],intentIdentifiers: [], options: [])
            
            center.setNotificationCategories([surveyAlarmCategory])
        } else {
            // TODO: Fallback on earlier versions for local notification categories (not implemented)
        }
    }
    
    @available(iOS 10.0, *)
    func addNotification(content:UNNotificationContent, trigger:UNNotificationTrigger?, indentifier:String) {
        
        let request = UNNotificationRequest(identifier: indentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { (errorObject) in
            if let error = errorObject{
                print("Error \(error.localizedDescription) in notification \(indentifier)")
                                                }
            }
        )
    }
}


extension ResearchContainerViewController: ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        // Check if the user has finished the `WithdrawViewController`.
        if taskViewController is WithdrawViewController {
            /*
             If the user has completed the withdrawl steps, remove them from
             the study and transition to the onboarding view.
             */
            if reason == .completed {
                UserDefaultHandler.sharedInstance.cleanUpUserDefaults()
                ORKPasscodeViewController.removePasscodeFromKeychain()
                ToDoSurveyList.sharedInstance.cleanUpToDoSurveyList()
                toOnboarding()
            }
            
            // Dismiss the `WithdrawViewController`.
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: Delegate

extension ResearchContainerViewController: UNUserNotificationCenterDelegate {
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let request = response.notification.request
        let categoryId = request.content.categoryIdentifier
        
        if(categoryId == "surveyAlarm.category") {
            // check snooze action            
            if response.actionIdentifier == "snooze"{
                let newContent = request.content.mutableCopy() as! UNMutableNotificationContent
                
                newContent.body = "10 Minuten Erinnerung"
                
                let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                addNotification(content: newContent, trigger: newTrigger, indentifier: request.identifier)
            }
            else {
                toStudy()
            }
        }
        // you must call the completion handler when you're done
        completionHandler()
    }
}

