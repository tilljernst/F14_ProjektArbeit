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
            // TODO: get data from the user survey ID and StartDate
            // read config result as ORKTaskResult
            let configTaskResults = taskViewController.result
            print(configTaskResults)
            // read every step result as ORKStepResult
            for stepResult in configTaskResults.results! as! [ORKStepResult]  {
                print("---")
                // read the answers in every step, if available
                for result in stepResult.results! {
                    print("Identifier \(result.identifier)")
                    print("Result \(result)")
                    switch(stepResult.identifier){
                    // read heart rate id as ORKTextQuestionResult
                    case(String(describing:Identifier.configurationHeartRateIdStep)):
                        let heartRateResult = result as! ORKTextQuestionResult
                        print("Value is \(String(describing: heartRateResult.textAnswer))")
                    // read start date
                    case (String(describing:Identifier.configurationStartDateStep)):
                        let startDateResult = result as! ORKDateQuestionResult
                        print("dateAnswer \(String(describing: startDateResult.dateAnswer))")
                        print("calendar \(String(describing: startDateResult.calendar))")
                        print("timeZone \(String(describing: startDateResult.timeZone))")
                    default:break
                    }
                    
                }
            }

//            
            
//            let heartRateQuestionResult = heartRateStepResult?.results as! ORKTextQuestionResult
//            print("Answer \(heartRateQuestionResult.textAnswer)")

//            var heartRateResult = configResult.stepResult(forStepIdentifier: String(describing:Identifier.configurationHeartRateIdStep))
//            
//            
//            var startDateResult = configResult.stepResult(forStepIdentifier: String(describing:Identifier.configurationStartDateStep))
//            
//            
            let appHandler = AppHandler()
            appHandler.initUserDefaults()
            appHandler.setUserDefaultsValue(userKey: String(describing:userDefaultKey.userId), value: "TestId")
            appHandler.setUserDefaultsValue(userKey: String(describing:userDefaultKey.startDate), value: "TestStartDate")
            
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

