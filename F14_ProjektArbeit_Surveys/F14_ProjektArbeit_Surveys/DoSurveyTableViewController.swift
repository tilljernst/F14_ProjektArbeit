//
//  DoSurveyTableViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 26.07.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import UIKit
import ResearchKit

class DoSurveyTableViewController: UITableViewController, ORKTaskViewControllerDelegate {
    var todoSurveyItems: [TodoSurveyItem] = []
    
    // MARK: Types
    
    enum TableViewCellIdentifier: String {
        case `default` = "ToDoSurvey"
    }
    
    let swiftDueColor = UIColor(red: 0, green: 204/255, blue: 0, alpha: 1) 
    
    // MARK: Properties
    
    /**
     When a task is completed, the `TaskListViewController` calls this closure
     with the created task.
     */
    var taskResultFinishedCompletionHandler: ((ORKResult) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(DoSurveyTableViewController.refreshList), name: NSNotification.Name(rawValue: "DoSurveyListShouldRefresh"), object: nil)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        
        refreshList()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshList() {
        todoSurveyItems = ToDoSurveyList.sharedInstance.allItems()
//        if (todoSurveyItems.count >= 64) {
//            self.navigationItem.rightBarButtonItem!.isEnabled = false // disable 'add' button
//        }
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todoSurveyItems.count
    }
    
    // darstellen der task liste
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.default.rawValue, for: indexPath) // retrieve the prototype cell (subtitle style)
        let todoItem = todoSurveyItems[(indexPath as NSIndexPath).row] as TodoSurveyItem
        
        cell.textLabel?.text = todoItem.surveyTitle as String!
        if (todoItem.becomeDue) { // the current time is later than the to-do item's deadline
            cell.detailTextLabel?.textColor = swiftDueColor
        } else {
            cell.detailTextLabel?.textColor = UIColor.black // we need to reset this because a cell with red subtitle may be returned by dequeueReusableCellWithIdentifier:indexPath:
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "'Due' MMM dd 'at' h:mm a" // example: "Due Jan 01 at 12:00 PM"
        cell.detailTextLabel?.text = "Due date: \(dateFormatter.string(from: todoItem.deadline as Date))."
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false // all cells are editable
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // get the todoItem
        let todoItem = todoSurveyItems[(indexPath as NSIndexPath).row] as TodoSurveyItem
        
        // item kann nur ausgeführt werden, wenn ausführzeit erreicht ist
        if(todoItem.becomeDue){
            // create a task
            let taskId = todoItem.surveyTaskId
            let task = ToDoSurveyTask.sharedInstance.getTaskBasedOnId(taskId: taskId)
            /*
             Passing `nil` for the `taskRunUUID` lets the task view controller
             generate an identifier for this run of the task.
             */
            let surveyTaskViewController = ORKTaskViewController(task: task, taskRun: nil)
            
            // Make sure we receive events from `taskViewController`.
            surveyTaskViewController.delegate = self
            
            // Assign a directory to store `taskViewController` output.
            surveyTaskViewController.outputDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            
            /*
             We present the task directly, but it is also possible to use segues.
             The task property of the task view controller can be set any time before
             the task view controller is presented.
             */
            present(surveyTaskViewController, animated: true, completion: nil)
        } else {
            // info fenster anzeigen
            let alertController = UIAlertController(title: "Survey Handler", message: "Sie können die Umfrage erst starten, wenn die Ausführzeit erreicht ist. Bitte gedulden Sie sich noch etwas.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) {action -> Void in
            }
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }

    // MARK: ORKTaskViewControllerDelegate
    
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            print(taskViewController.result)
            // get data from survey and do something with it
            DoSurveyHelper.sharedInstance.processResultsWithUpload(SurveyResult: taskViewController.result)
            
            // remove task from list with corresponding identifier
            ToDoSurveyList.sharedInstance.removeDoneItem(ORKTaskIdentifier: taskViewController.result.identifier)
            
            //performSegue(withIdentifier: "unwindToStudy", sender: nil)
            taskViewController.dismiss(animated: true, completion: nil)
        case .discarded, .failed, .saved:
           taskViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete { // the only editing style we'll support
            // Delete the row from the data source
            let item = todoSurveyItems.remove(at: (indexPath as NSIndexPath).row) // remove TodoItem from notifications array, assign removed item to 'item'
            tableView.deleteRows(at: [indexPath], with: .fade)
            ToDoSurveyList.sharedInstance.removeItem(item) // delete backing property list entry and unschedule local notification (if it still exists)
            self.navigationItem.rightBarButtonItem!.isEnabled = true // we definitely have under 64 notifications scheduled now, make sure 'add' button is enabled
        }
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return false
    }
}
