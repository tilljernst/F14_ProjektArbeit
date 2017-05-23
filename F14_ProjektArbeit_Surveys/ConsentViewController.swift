//
//  ConsentViewController.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import UIKit
import ResearchKit

class ConsentViewController: UIViewController {
    
    @IBAction func tappedButton(_ sender: Any) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

//MARK: - ORKTaskViewController Delegate Methods
extension ConsentViewController : ORKTaskViewControllerDelegate {
    
    // wird aufgerufen, wenn task beendet wurde
    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        
        //Handle results with taskViewController.result
        //processSurveyResults(taskViewController.result)
        
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
}
