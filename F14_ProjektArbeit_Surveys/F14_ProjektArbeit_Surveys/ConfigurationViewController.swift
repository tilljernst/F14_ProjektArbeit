//
//  ConfigurationViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

//
//  ConsentViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import UIKit
import ResearchKit

class ConfigurationViewController: UIViewController {
    
    @IBAction func withdrawButtonTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "unwindToWithdrawl", sender: nil)
    }
    
    @IBAction func configurationButtonTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConfigurationTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

//MARK: - ORKTaskViewController Delegate Methods
extension ConfigurationViewController : ORKTaskViewControllerDelegate {
    
    // wird aufgerufen, wenn task beendet wurde
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            // read config result as ORKTaskResult
            let configTaskResults = taskViewController.result
            print(configTaskResults)
            var heartRateId:String = ""
            var startDate:String = ""
            var configDate:String = ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.YYYY HH:mm:ss"
            configDate = dateFormatter.string(from: configTaskResults.startDate)
            print("configurationDate \(String(describing: configDate))")
            // read every step result as ORKStepResult
            for stepResult in configTaskResults.results! as! [ORKStepResult]  {
                // read the answers in every step, if available
                for result in stepResult.results! {
                    print("Identifier \(result.identifier)")
                    print("Result \(result)")
                    switch(stepResult.identifier){
                    // read heart rate id as ORKTextQuestionResult
                    case(String(describing:Identifier.configurationHeartRateIdStep)):
                        let heartRateResult = result as! ORKTextQuestionResult
                        heartRateId = heartRateResult.textAnswer!
                        print("Value is \(String(describing: heartRateId))")
                    // read start date
                    case (String(describing:Identifier.configurationStartDateStep)):
                        let startDateResult = result as! ORKDateQuestionResult
                        dateFormatter.dateFormat = "dd.MM.YYYY"
                        startDate = dateFormatter.string(from: startDateResult.dateAnswer!)
                        print("dateAnswer \(String(describing: startDate))")
                        print("calendar \(String(describing: startDateResult.calendar))")
                        print("timeZone \(String(describing: startDateResult.timeZone))")
                    default:break
                    }                    
                }
            }
            let appHandler = AppHandler()
            appHandler.initUserDefaults()
            appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.userId), value: heartRateId)
            appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.startDate), value: startDate)
            appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: configDate)
            performSegue(withIdentifier: "unwindToStudy", sender: nil)
            
        case .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
        }
    }
    
    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
        if step is HealthDataStep {
            let healthStepViewController = HealthDataStepViewController(step: step)
            return healthStepViewController
        }
        
        return nil
    }
    
}

