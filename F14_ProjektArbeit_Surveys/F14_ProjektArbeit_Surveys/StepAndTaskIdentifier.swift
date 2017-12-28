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
    case consentVisualStep
    case consentTask
    case consentSharingStep
    case consentReviewStep
    case consentDocumentParticipantSignature
    case consentCompetionStep
    
    //configuration
    case configurationTask
    case configurationInstructionStep
    case configurationHeartRateIdStep
    case configurationStartDateStep
    
    // Withdrawl
    case withdrawlInstructionStep
    case withdrawlStep
    case withdrawlTask
    
    // Task for personal datas
    case personTask
    case personInstructionStep
    case personFormStep
    case personGenderStep
    case personYearStep
    case personHeightStep
    case personWeightStep
    case personLifeFormStep
    case personKidsStep
    case personKidsTotalStep
    case personKidsAgeFormStep
    case personKidsAgeFormItemFirst
    case personKidsAgeFormItemSecond
    case personKidsAgeFormItemThird
    case personKidsAgeFormItemFourth
    case personKidsSupervisionFormStep
    case personKidsSupervisionItemFirst
    case personKidsSupervisionItemSecond
    case personKidsSupervisionItemThird
    case personKidsSupervisionItemFourth
    case personHoushold
    case personCarsStep
    case personHolidayStep
    case personComputerStep
    case personBathroomStep
    case personCompletionStep
    
    // Task for equipment usage
    case equipmentTask
    case equipmentFormStep
    case equipmentQuestionStep
    case equipmentFormItemSmartphone
    case equipmentFormItemTv
    case equipmentFormItemDesktop
    case equipmentFormItemTablet
    case equipmentFormItemRadio
    case equipmentFormItemVideogame
    case equipmentInstructionStep
    case equipmentCompletionStep
    
    // Task for operation
    case operationTask
    case operationInstructionStep
    case operationFormStep
    case operationFormItemTv
    case operationFormItemRadio
    case operationFormItemVideogame
    case operationFormItemMusic
    case operationFormItemSocialNetwork
    case operationFormItemYoutube
    case operationFormItemEmail
    case operationFormItemOffice
    case operationFormItemGrafic
    case operationFormItemInternetInfo
    case operationFormItemInternetSurfing
    case operationFormItemMessage
    case operationFormItemFotos
    case operationFormItemFace2Face
    case operationFormItemOutdoor
    case operationFormItemSport
    case operationFormItemHobby
    case operationFormItemCinema
    case operationCompletionStep
    
    // Task for medial content
    case medialContentFormStep
    case medialContentFormItemTv
    case medialContentFormItemRadio
    case medialContentFormItemGaming
    case medialContentFormItemMusic
    case medialContentFormItemSocialNetwork
    case medialContentFormItemVideo
    
    // Task for fitness
    case fitnessTask
    case fitnessInstructionStep
    case fitnessCompletionStep
    
    // end of day
    case endOfDayTask
    case endOfDayInstructionStep
    case consumptionFormStep
    case consumptionZigaretten
    case consumptionAlkohol
    case consumptionKaffee
    case technoStressFormStep
    case technoStressTimePressure
    case technoStressWorkAdaption
    case technoStressComplexity
    case technoStressFamily
    case technoStressEmail
    case technoStressContinousChange
    case technoStressChangingApps
    case technoStressUpgrade
    case endOfDayCompletionStep
    
    // sleep quality
    case sleepTask
    case sleepInstructionStep
    case sleepCompletionstep
    
    // default task
    case defaultTask
}
