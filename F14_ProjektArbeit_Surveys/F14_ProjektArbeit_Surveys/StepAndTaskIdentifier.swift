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
    case relaxationNew_Q9
    case relaxationMental_Q10
    case relaxationChallenge_Q11
    case relaxationHorizon_Q12
    case relaxationDecide_Q13
    case relaxationActivity_Q14
    case relaxationTime_Q15
    case relaxationThings_Q16
    case dailyHasslesFormStep_Set1
    case dailyHasslesFormStep_Set2
    case dailyHasslesFormStep_Set3
    case dailyHasslesTask_Q1
    case dailyHasslesPerformance_Q2
    case dailyHasslesWork_Q3
    case dailyHasslesRush_Q4
    case dailyHasslesDisturbed_Q5
    case dailyHasslesMaster_Q6
    case dailyHasslesToEnd_Q7
    case dailyHasslesMess_Q8
    case dailyHasslesBadMouth_Q9
    case dailyHasslesRespect_Q10
    case dailyHasslesPublic_Q11
    case dailyHasslesUnfriendly_Q12
    case dailyHasslesInterrupted_Q13
    case dailyHasslesPeople_Q14
    case dailyHasslesPromise_Q15
    case dailyHasslesCompetition_Q16
    case dailyHasslesGlare_Q17
    case dailyHasslesNotHeard_Q18
    case dailyHasslesDistrust_Q20
    case dailyHasslesEmbarassed_Q21
    case dailyHasslesForget_Q23
    case dailyHasslesIllness_Q24
    case dailyHasslesPhysical_Q25
    case dailyHasslesBorrow_Q26
    case dailyHasslesBroken_Q27
    case dailyHasslesMishap_Q28
    case dailyHasslesFuture_Q29
    case dailyHasslesFood_Q30
    case dailyHasslesArgument_Q31
    case dailyHasslesQuarrel_Q32
    case dailyHasslesWaiting_Q33
    case dailyHasslesDisturbed_Q34
    case dailyHasslesPress_Q35
    case dailyHasslesSport_Q36
    case dailyHasslesWouldnt_Q37
    case dailyHasslesExecute_Q38
    case dailyHasslesCar_Q39
    case dailyHasslesNervous_Q40
    case dailyHasslesTrouble_Q41
    case dailyHasslesStore_Q42
    case dailyHasslesRelocate_Q43
    case dailyHasslesWeather_Q44
    case dailyHasslesSpending_Q45
    case dailyHasslesAuthority_Q46
    case dailyHasslesMessage_Q47
    case dailyHasslesExternal_Q48
    case dailyHasslesDrastic_Q49
    case dailyHasslesBadTempered_Q50
    case dailyHasslesMissunderstanding_Q51
    case dailyHasslesSorrow_Q52
    case dailyHasslesDanger_Q53
    case dailyHasslesBadHabit_Q54
    case dailyHasslesKids_Q55
    case dailyHasslesLate_Q56
    
    // sleep quality
    case blockE_sleepTask
    case blockE_sleepInstructionStep
    case blockE_sleepCompletionstep
    case sleepQualityFallAsleep_Q1
    case sleepQualityWakeUp_Q2
    case sleepQualityDuration_Q3
    case sleepQualityBeforeLightOut_Q4
    case sleepQualityUntilSleep_Q5
    case sleepQualityCompare_Q6
    case sleepQualityFormStep
    case sleepQualityNightQuality_Q1
    case sleepQualityNightFallback_Q2
    case sleepQualityNightSleep_Q3
    case sleepQualityNightTired_Q4
    case sleepQualityNightTrouble_Q5
    case sleepQualityNightNap_Q6
    case sleepQualityNightHappy_Q7
    case sleepQualityNightSleepy_Q8
    case sleepQualityNightNightmare_Q9
    case sleepQualityMentalStateFormStep
    case sleepQualityMentalStateStressed_Q1
    case sleepQualityMentalStateFresh_Q2
    case sleepQualityMentalStateDepressed_Q3
    case sleepQualityMentalStateRelaxed_Q4
    
    // default task
    case defaultTask
}
