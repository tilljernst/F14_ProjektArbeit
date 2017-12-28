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
    
    // Block - A
    // Task for personal datas
    case blockA_personTask
    case blockA_personInstructionStep
    case blockA_personCompletionStep
    case personFormStep
    case personGender_Q1
    case personYear_Q2
    case personHeight_Q3
    case personWeight_Q4
    case personLifeForm_Q5
    case personKids_Q6
    case personKidsTotalStep
    case personKidsAge_Q7
    case personKidsAgeFormItemFirst
    case personKidsAgeFormItemSecond
    case personKidsAgeFormItemThird
    case personKidsAgeFormItemFourth
    case personKidsSupervision_Q8
    case personKidsSupervisionItemFirst
    case personKidsSupervisionItemSecond
    case personKidsSupervisionItemThird
    case personKidsSupervisionItemFourth
    case personHoushold_Q9
    case personCars_Q10
    case personHoliday_Q11
    case personComputer_Q12
    case personBathroom_Q13
    
    // Block - B
    // Task for equipment usage
    case blockB_equipmentTask
    case blockB_equipmentInstructionStep
    case blockB_equipmentCompletionStep
    case equipmentFormStep
    case equipmentQuestionStep
    case equipmenSmartphone_Q1
    case equipmentTv_Q2
    case equipmentDesktop_Q3
    case equipmentTablet_Q4
    case equipmentRadio_Q5
    case equipmentVideogame_Q6
    
    // Task for operation
    case mediaActivityTask
    case mediaActivityInstructionStep
    case mediaActivityFormStep
    case mediaActivityCompletionStep
    case mediaActivityTv_Q1
    case mediaActivityRadio_Q2
    case mediaActivityVideogame_Q3
    case mediaActivityMusic_Q4
    case mediaActivitySocialNetwork_Q5
    case mediaActivityYoutube_Q6
    case mediaActivityEmail_Q7
    case mediaActivityOffice_Q8
    case mediaActivityGrafic_Q9
    case mediaActivityInternetInfo_Q10
    case mediaActivityInternetSurfing_Q11
    case mediaActivityMessage_Q12
    case mediaActivityFotos_Q13
    case mediaActivityFace2Face_Q14
    case mediaActivityOutdoor_Q15
    case mediaActivitySport_Q16
    case mediaActivityHobby_Q17
    case mediaActivityCinema_Q18
    
    // Task for medial content
    case mediaContentFormStep
    case mediaContentTv_Q1
    case mediaContentRadio_Q2
    case mediaContentGaming_Q3
    case mediaContentMusic_Q4
    case mediaContentSocialNetwork_Q5
    case mediaContentVideo_Q6
    
    // Block - C
    // Task for fitness
    case blockC_fitnessTask
    
    // Block - D
    // end of day
    case blockD_EndOfDayTask
    case blockD_EndOfDayInstructionStep
    case blockD_EndOfDayCompletionStep
    case consumptionFormStep
    case consumptionZigaretten_Q1
    case consumptionAlkohol_Q2
    case consumptionKaffee_Q3
    case technoStressFormStep
    case technoStressTimePressure_Q1
    case technoStressWorkAdaption_Q2
    case technoStressComplexity_Q3
    case technoStressFamily_Q4
    case technoStressEmail_Q5
    case technoStressContinousChange_Q7
    case technoStressChangingApps_Q8
    case technoStressUpgrade_Q9
    case hedonismFormStep
    case hedonismEntertainment_Q1
    case hedonismFun_Q2
    case hedonismJoyful_Q3
    case relaxationFormStep
    case relaxationWorkForget_Q1
    case relaxationWorkThink_Q2
    case relaxationWorkDistance_Q3
    case relaxationWorkRequirement_Q4
    case relaxationSoul_Q5
    case relaxationEase_Q6
    case relaxationRelax_Q7
    case relaxationLeisure_Q8
    case relaxationNew_Q10
    case relaxationMental_Q11
    case relaxationChallenge_Q12
    case relaxationHorizon_Q13
    case relaxationDecide_Q14
    case relaxationActivity_Q15
    case relaxationTime_Q16
    case relaxationThings_Q17
    case dailyHasslesFormStep
    case dailyHasslesTask_Q1
    
    // sleep quality
    case blockE_sleepTask
    case blockE_sleepInstructionStep
    case blockE_sleepCompletionstep
    
    // default task
    case defaultTask
}
