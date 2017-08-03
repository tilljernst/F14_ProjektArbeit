//
//  ConsentMenueViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 27.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//



import UIKit
import ResearchKit

class ConsentMenueViewController: UIViewController {
    // MARK: IB actions
    
    @IBAction func showConsentButtonTapped(_ sender: UIButton) {
        showConsent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        showConsent()
    }
    
    func showConsent(){
        let taskViewController = ORKTaskViewController(task: ConsentReviewTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }

    func switchToDoSurveyTabCont(){
        tabBarController?.selectedIndex = 1
    }

}

extension ConsentMenueViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {            
        case .completed, .discarded, .failed, .saved:
            dismiss(animated: true, completion: nil)
            switchToDoSurveyTabCont()
        }
    }
    
//    func taskViewController(_ taskViewController: ORKTaskViewController, viewControllerFor step: ORKStep) -> ORKStepViewController? {
//        if step is HealthDataStep {
//            let healthStepViewController = HealthDataStepViewController(step: step)
//            return healthStepViewController
//        }
//        
//        return nil
//    }
}

