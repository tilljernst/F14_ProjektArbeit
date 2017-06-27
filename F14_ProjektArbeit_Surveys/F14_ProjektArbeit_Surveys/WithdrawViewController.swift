//
//  WithdrawViewController.swift
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

class WithdrawViewController: ORKTaskViewController {
    // MARK: Initialization
    
    init() {
        let instructionStep = ORKInstructionStep(identifier: String(describing:Identifier.withdrawlInstructionStep))
        instructionStep.title = NSLocalizedString("Sind Sie sicher, dass Sie die Teilnahme an der Umfrage Widerrufen wollen?", comment: "")
        instructionStep.text = NSLocalizedString("Der Abbruch der Studie führt dazu, dass die App auf den Ursprungszustand vor Ihrer Teilnahme an der Studie zurückgesetzt wird.", comment: "")
        
        let completionStep = ORKCompletionStep(identifier: String(describing:Identifier.withdrawlStep))
        completionStep.title = NSLocalizedString("Wir bedanken uns für Ihre Zeit, die Sie sich genommen haben.", comment: "")
        completionStep.text = NSLocalizedString("Vielen Dank für die Teilnahme. Wir bedauern es, können Sie nicht weiter an der Stuide teilnehmen.", comment: "")
        
        let withdrawTask = ORKOrderedTask(identifier: String(describing:Identifier.withdrawlTask), steps: [instructionStep, completionStep])
        
        super.init(task: withdrawTask, taskRun: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

