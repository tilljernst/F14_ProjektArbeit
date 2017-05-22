//
//  ResearchKitTableViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 22.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import UIKit
import ResearchKit

class ResearchKitTableViewController: UITableViewController, ORKTaskViewControllerDelegate {

    var waitStepViewController: ORKWaitStepViewController?
    var waitStepUpdateTimer: Timer?
    var waitStepProgress: CGFloat = 0.0
    
    // MARK: Types
    
    enum TableViewCellIdentifier: String {
        case `default` = "ResearchKit"
    }
    
    // MARK: Properties
    
    /**
     When a task is completed, the `TaskListViewController` calls this closure
     with the created task.
     */
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskListRow.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskListRow.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskListRow.sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.default.rawValue, for: indexPath)
        
        let taskListRow = TaskListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        cell.textLabel!.text = "\(taskListRow)"
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Present the task view controller that the user asked for.
        let taskListRow = TaskListRow.sections[(indexPath as NSIndexPath).section].rows[(indexPath as NSIndexPath).row]
        
        // Create a task from the `TaskListRow` to present in the `ORKTaskViewController`.
        let task = taskListRow.representedTask
        
        /*
         Passing `nil` for the `taskRunUUID` lets the task view controller
         generate an identifier for this run of the task.
         */
        let taskViewController = ORKTaskViewController(task: task, taskRun: nil)
        
        // Make sure we receive events from `taskViewController`.
        taskViewController.delegate = self
        
        // Assign a directory to store `taskViewController` output.
        taskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        /*
         We present the task directly, but it is also possible to use segues.
         The task property of the task view controller can be set any time before
         the task view controller is presented.
         */
        present(taskViewController, animated: true, completion: nil)
    }
    
    
    // MARK: ORKTaskViewControllerDelegate
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        /*
         The `reason` passed to this method indicates why the task view
         controller finished: Did the user cancel, save, or actually complete
         the task; or was there an error?
         
         The actual result of the task is on the `result` property of the task
         view controller.
         */
        taskResultFinishedCompletionHandler?(taskViewController.result)
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, stepViewControllerWillAppear stepViewController: ORKStepViewController) {
        // Example data processing for the wait step.
        if stepViewController.step?.identifier == "WaitStepIndeterminate" ||
            stepViewController.step?.identifier == "WaitStep" ||
            stepViewController.step?.identifier == "LoginWaitStep" {
            delay(5.0, closure: { () -> () in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    stepViewController.goForward()
                }
            })
        } else if stepViewController.step?.identifier == "WaitStepDeterminate" {
            delay(1.0, closure: { () -> () in
                if let stepViewController = stepViewController as? ORKWaitStepViewController {
                    self.waitStepViewController = stepViewController;
                    self.waitStepProgress = 0.0
                    self.waitStepUpdateTimer = Timer(timeInterval: 0.1, target: self, selector: #selector(SurveyTableViewController.updateProgressOfWaitStepViewController), userInfo: nil, repeats: true)
                    RunLoop.main.add(self.waitStepUpdateTimer!, forMode: RunLoopMode.commonModes)
                }
            })
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let delayTime = DispatchTime.now() + delay
        let dispatchWorkItem = DispatchWorkItem(block: closure);
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: dispatchWorkItem)
    }
    
    func updateProgressOfWaitStepViewController() {
        if let waitStepViewController = waitStepViewController {
            waitStepProgress += 0.01
            DispatchQueue.main.async(execute: { () -> Void in
                waitStepViewController.setProgress(self.waitStepProgress, animated: true)
            })
            if (waitStepProgress < 1.0) {
                return
            } else {
                self.waitStepUpdateTimer?.invalidate()
                waitStepViewController.goForward()
                self.waitStepViewController = nil
            }
        } else {
            self.waitStepUpdateTimer?.invalidate()
        }
    }
    
}
