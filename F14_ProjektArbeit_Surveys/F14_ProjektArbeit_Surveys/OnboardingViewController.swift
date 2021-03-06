//
//  OnboardingViewController.swift
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

class OnboardingViewController: UIViewController {
    // MARK: IB actions
    
    @IBAction func starteUmfrageButtonTapped(_ sender: UIButton) {
        let taskViewController = ORKTaskViewController(task: ConsentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)

//        // the following code was taken from the research kit example
//        let consentDocument = ConsentDocumentResearchKit()
//        let consentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
//        
//        let healthDataStep = HealthDataStep(identifier: "Health")
//        
//        let signature = consentDocument.signatures!.first!
//        
//        let reviewConsentStep = ORKConsentReviewStep(identifier: "ConsentReviewStep", signature: nil, in: consentDocument)
//        
//        reviewConsentStep.text = "Review the consent form."
//        reviewConsentStep.reasonForConsent = "Consent to join the Developer Health Research Study."
//        
//        let passcodeStep = ORKPasscodeStep(identifier: "Passcode")
//        passcodeStep.text = "Now you will create a passcode to identify yourself to the app and protect access to information you've entered."
//        
//        let completionStep = ORKCompletionStep(identifier: "CompletionStep")
//        completionStep.title = "Welcome aboard."
//        completionStep.text = "Thank you for joining this study."
//        
//        let orderedTask = ORKOrderedTask(identifier: "Join", steps: [consentStep, reviewConsentStep,healthDataStep, passcodeStep, completionStep])
//        let taskViewController = ORKTaskViewController(task: orderedTask, taskRun: nil)
//        taskViewController.delegate = self
//        
//        present(taskViewController, animated: true, completion: nil)
    }
}

extension OnboardingViewController : ORKTaskViewControllerDelegate {
    
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        switch reason {
        case .completed:
            // TODO: safe as pdf
            let signatureResult:ORKConsentSignatureResult = taskViewController.result.stepResult(forStepIdentifier: String(describing:Identifier.consentReviewStep))?.firstResult as! ORKConsentSignatureResult
            createPdf(result: signatureResult)
            
            performSegue(withIdentifier: "unwindToConfiguration", sender: nil)
            
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
    
    func createPdf(result: ORKConsentSignatureResult){
        let documentCopy: ORKConsentDocument = ConsentDocument.copy() as! ORKConsentDocument
        result.apply(to: documentCopy)
        
        documentCopy.makePDF(completionHandler: { (pdfFile, error) -> Void in
            print("consent pdf created")
            // finding document path  //TODO: Remove if not needed
            //Get the local docs directory and append your local filename.
            var dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            dir = dir?.appendingPathComponent("MediaSurveyConsent.pdf")
            
            //Lastly, write your file to the disk.
            do{
                try pdfFile?.write(to: dir! as URL)
            }
            catch { print("could not write consent pdf to local directory") }
        })
    }
}

