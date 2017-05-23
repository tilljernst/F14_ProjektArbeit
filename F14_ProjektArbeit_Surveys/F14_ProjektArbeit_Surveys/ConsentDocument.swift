//
//  ConsentDocument.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import ResearchKit

public var ConsentDocument: ORKConsentDocument{
    let consentDocument = ORKConsentDocument()
    consentDocument.title = "Einverständniserklärung"
    
    // consent sections
    let consentSectionTypes: [ORKConsentSectionType] = [
        .overview,
        .dataGathering,
        .privacy,
        .dataUse,
        .timeCommitment,
        .studySurvey,
        .studyTasks,
        .withdrawing
    ]
    
    let overviewSection = ORKConsentSection(type: ORKConsentSectionType.overview)
    overviewSection.content = "Content of the overview"
    
    
    consentDocument.sections = [overviewSection]
    
//    let consentSections: [ORKConsentSection] = consentSectionTypes.map { contentSectionType in
//        let consentSection = ORKConsentSection(type: contentSectionType)
//        consentSection.summary = "If you wish to complete this study..."
//        consentSection.content = "In this study you will be asked five (wait, no, three!) questions. You will also have your voice recorded for ten seconds."
//        return consentSection
//    }
//    
//    consentDocument.sections = consentSections
    
    // signature
    consentDocument.addSignature(ORKConsentSignature(forPersonWithTitle: nil, dateFormatString: nil, identifier: "ConsentDocumentParticipantSignature"))
    
    return consentDocument
}

