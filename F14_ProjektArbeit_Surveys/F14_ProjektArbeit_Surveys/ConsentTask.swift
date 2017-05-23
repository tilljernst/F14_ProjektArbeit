//
//  ConsentTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import ResearchKit



public var ConsentTask: ORKOrderedTask {
    
    //Add VisualConsentStep
    let consentDocument = ConsentDocument
    let visualConsentStep = ORKVisualConsentStep(identifier: "VisualConsentStep", document: consentDocument)
    
    let investigatorShortDescription = NSLocalizedString("Institution", comment: "")
    let investigatorLongDescription = NSLocalizedString("Institution and its partners", comment: "")
    let localizedLearnMoreHTMLContent = NSLocalizedString("Your sharing learn more content here.", comment: "")
    
    /*
     If you want to share the data you collect with other researchers for
     use in other studies beyond this one, it is best practice to get
     explicit permission from the participant. Use the consent sharing step
     for this.
     */
    let sharingConsentStep = ORKConsentSharingStep(identifier: String(describing:Identifier.consentSharingStep), investigatorShortDescription: investigatorShortDescription, investigatorLongDescription: investigatorLongDescription, localizedLearnMoreHTMLContent: localizedLearnMoreHTMLContent)
    
    /*
     After the visual presentation, the consent review step displays
     your consent document and can obtain a signature from the participant.
     
     The first signature in the document is the participant's signature.
     This effectively tells the consent review step which signatory is
     reviewing the document.
     */
    let signature = consentDocument.signatures!.first
    
    let reviewConsentStep = ORKConsentReviewStep(identifier: String(describing:Identifier.consentReviewStep), signature: signature, in: consentDocument)
    
    // In a real application, you would supply your own localized text.
    reviewConsentStep.text = "review consent step"
    reviewConsentStep.reasonForConsent = "reson for consent"
    
    return ORKOrderedTask(identifier: String(describing:Identifier.consentTask), steps: [
        visualConsentStep,
        sharingConsentStep,
        reviewConsentStep
        ])
}
