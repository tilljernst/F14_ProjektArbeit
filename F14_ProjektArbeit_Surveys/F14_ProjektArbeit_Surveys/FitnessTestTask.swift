//
//  FitnessTestTask.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 01.08.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

extension ToDoSurveyTask{
    /**
     This task is available in survey Block C
     This task presents the Fitness pre-defined active task. For this example,
     short walking and rest durations of 20 seconds each are used, whereas more
     realistic durations might be several minutes each.
     */
    func fitnessTask() -> ORKTask {
        return ORKOrderedTask.fitnessCheck(withIdentifier: String(describing:Identifier.fitnessTask), intendedUseDescription: "20 Sekunden schnell laufen, anschliessend 20 Sekunden absitzen und Puls messen.", walkDuration: 20, restDuration: 20, options: [.excludeAudio])
    }
}
