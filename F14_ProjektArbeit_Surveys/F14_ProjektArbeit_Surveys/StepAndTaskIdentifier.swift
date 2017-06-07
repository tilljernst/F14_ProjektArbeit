//
//  StepAndTaskIdentifier.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 23.05.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation

// MARK: Types

/**
 Every step and task in the ResearchKit framework has to have an identifier.
 Within a task, the step identifiers should be unique.
 
 Here we use an enum to ensure that the identifiers are kept unique. Since
 the enum has a raw underlying type of a `String`, the compiler can determine
 the uniqueness of the case values at compile time.
 
 In a real application, the identifiers for your tasks and steps might
 come from a database, or in a smaller application, might have some
 human-readable meaning.
 */
public enum Identifier {
    // Task consent
    case consentTask
    case consentSharingStep
    case consentReviewStep
    case consentDocumentParticipantSignature
    
    // Task for personal datas
    case personTask
    case personInstructionStep
    case personFormStep
    case personGenderStep
    case personYearStep
    case personHeightStep
    case personWeightStep
    case personCompletionStep
    
    // Task for equipment usage
    case equipmentTask
    case equipmentInstructionStep
    case operationTask
    case operationInstructionStep
}