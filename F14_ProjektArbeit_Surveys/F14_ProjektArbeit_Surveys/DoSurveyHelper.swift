//
//  DoSurveyHelper.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 17.10.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import ResearchKit

extension DoSurveyTableViewController{
    func processResultsWithUpload(SurveyResult result: ORKTaskResult){
        do {
            //1 This creates a unique folder and ZIP archive to store the task result files.
            /*
            let path = try createUniqueTaskResultsFolder(result!.taskRunUUID)
            let zipPath = (path as NSString). stringByAppendingPathComponent("\(taskResult!.taskRunUUID.UUIDString). zip")
            let zipArchive = try ZZArchive(URL: NSURL(fileURLWithPath: zipPath), options: [ZZOpenOptionsCreateIfMissingKey : true])
            */
            //2 This calls the method that we just created. It also checks whether the dictionary can be converted to JSON.
            if let dict = dictFromTaskResult(taskResult: result/*, zipArchive: zipArchive*/), JSONSerialization.isValidJSONObject(dict) {
                //3 This converts the dictionary to a JSON object and prints it in the console.
                let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                print(String(data: json, encoding: String.Encoding.utf8)!)
                //4 This writes the JSON object to the ZIP archive as a taskResult.json file.
                // TBD: try writeToZip(zipArchive, data: json, fileName: "taskResult.json")
                //5 This uploads the ZIP file to .RKBackendServerSample
                // TBD: uploadZipToRKBackendServer(zipPath)
            }
            else {
                print("Cannot convert to JSON")
            }
        }
        catch {
            print(error)
        }
    }
    
    func dictFromTaskResult(taskResult: ORKTaskResult/*, zipArchive: ZZArchive*/) -> [String : AnyObject]?{
        var retDict : [String:AnyObject] = [:]
        
        //1 This stores taskRunId, start date, and end date
        retDict["taskRunUUID"] = taskResult.taskRunUUID.uuidString as AnyObject
        retDict["startDate"] = "\(taskResult.startDate)" as AnyObject
        retDict["endDate"] = "\(taskResult.endDate)" as AnyObject
        
        //2
        for result in taskResult.results!
        {
            if let stepResult = result as? ORKStepResult
            {
                //3
                retDict[stepResult.identifier] = dictFromStepResult(stepResult: stepResult/*, zipArchive: zipArchive*/) as AnyObject
            }
        }
        
        //4
        return [taskResult.identifier : retDict as AnyObject]
    }
    
    func dictFromStepResult (stepResult: ORKStepResult/*, zipArchive: ZZArchive*/) -> [String : AnyObject]?{
        var retDict : [String:AnyObject] = [:]
        
        //1
        retDict["startDate"] = "\(stepResult.startDate)" as AnyObject
        retDict["endDate"] = "\(stepResult.endDate)" as AnyObject
        
        //2
        for result in stepResult.results!
        {
            //3
            if result is ORKQuestionResult
            {
                //4 This uses the custom enum and stringValue ORKQuestionResult methods to convert to a string
                retDict["\((result as! ORKQuestionResult).questionType.stringValue())"] = "\((result as! ORKQuestionResult).stringValue())" as AnyObject
            }
        }
        return retDict
    }
    
   
            
            
}

extension ORKQuestionType {
    func stringValue() -> String {
        var retString = "None"
        switch self {
        case .none:
            retString = "None"
        case .scale:
            retString = "Scale"
        case .singleChoice:
            retString = "SingleChoice"
        case .multipleChoice:
            retString = "MultipleChoice"
        case .decimal:
            retString = "Integer"
        case .integer:
            retString = "Integer"
        case .boolean:
            retString = "Boolean"
        case .text:
            retString = "Text"
        case .timeOfDay:
            retString = "TimeOfDay"
        case .dateAndTime:
            retString = "DateAndTime"
        case .date:
            retString = "Date"
        case .timeInterval:
            retString = "TimeInterval"
        case .location:
            retString = "Location"
        case .multiplePicker:
            retString = "MultiplePicker"
        case .height:
            retString = "Height"
        }
        return retString}
}

extension ORKQuestionResult {
    
    func stringValue() ->String {
        var retString = "None"
        switch self.questionType {
        case .none:
            retString = "None"
        case .scale:
            retString = (self as! ORKScaleQuestionResult).scaleAnswer?.description ?? "Skipped"
        case .singleChoice: fallthrough
        case .multipleChoice:
            retString = (self as! ORKChoiceQuestionResult).choiceAnswers?.description ?? "Skipped"
        case .decimal:
            fallthrough
        case .integer:
            retString = (self as! ORKNumericQuestionResult).numericAnswer?.description ?? "Skipped"
        case .boolean:
            retString = (self as! ORKBooleanQuestionResult).booleanAnswer?.description ?? "Skipped"
        case .text:
            retString = (self as! ORKTextQuestionResult).textAnswer ?? "Skipped"
        case .timeOfDay:
            retString = (self as! ORKTimeOfDayQuestionResult).dateComponentsAnswer?.description ?? "Skipped"
        case .dateAndTime:
            fallthrough          
        case .date:
            retString = (self as! ORKDateQuestionResult).dateAnswer?.description ?? "Skipped"
        case .timeInterval:
            retString = (self as! ORKTimeIntervalQuestionResult).intervalAnswer?.description ?? "Skipped"
        case .location:
            retString = (self as! ORKLocationQuestionResult).locationAnswer?.description ?? "Skipped"
        case .multiplePicker:
            retString = (self as! ORKMultipleComponentQuestionResult).componentsAnswer?.description ?? "Skipped"
        case .height:
            retString = (self as! ORKNumericQuestionResult).numericAnswer?.description ?? "Skipped"
        }
        return retString
    }
}
