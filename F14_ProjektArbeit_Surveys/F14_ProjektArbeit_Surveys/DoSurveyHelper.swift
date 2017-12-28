//
//  DoSurveyHelper.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 17.10.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import Foundation
import UIKit
import ResearchKit
import ZipZap

/*********************************************************************************/
//MARK: - RK Results
/*********************************************************************************/
class DoSurveyHelper{
    class var sharedInstance : DoSurveyHelper {
        struct Static {
            static let instance: DoSurveyHelper = DoSurveyHelper()
        }
        return Static.instance
    }
    
    let zipPathDateAddition: () -> (String) = {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return "\(year)\(month)\(day)_"
    }
    
    let fileName: (ORKTaskResult) -> (String) = {result in
        let taskIdentifier = result.identifier
        let heartRateId = NSLocalizedString(UserDefaultHandler.sharedInstance.getUserDefaultsValue(userKey: String(describing: UserDefaultKey.userId))!, comment: "")
        var jsonFileName = "\(heartRateId)_\(taskIdentifier)_\(result.endDate)"
        jsonFileName = jsonFileName.replacingOccurrences(of: " +0000", with: "", options: .literal, range: nil)
        jsonFileName = jsonFileName.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        return "\(jsonFileName).json"
    }
    
    func processResultsWithUpload(SurveyResult result: ORKTaskResult){
        do {
            //1 This creates a unique folder and ZIP archive to store the task result files.
            let path = try createUniqueTaskResultsFolder(uuid: result.taskRunUUID as NSUUID)
            let zipPath = (path as NSString).appendingPathComponent("\(zipPathDateAddition())\(result.taskRunUUID.uuidString).zip")
            let zipArchive = try ZZArchive(url: NSURL(fileURLWithPath: zipPath) as URL, options: [ZZOpenOptionsCreateIfMissingKey : true])
            //2 This calls the method that we just created. It also checks whether the dictionary can be converted to JSON.
            if let dict = dictFromTaskResult(taskResult: result, zipArchive: zipArchive), JSONSerialization.isValidJSONObject(dict) {
                //3 This converts the dictionary to a JSON object and prints it in the console.
                let json = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                print("Serialized data ready to upload to the server:")
                print(String(data: json, encoding: String.Encoding.utf8)!)
                //4 This writes the JSON object to the ZIP archive as a taskResult.json file.
                try writeToZip(archive: zipArchive, data: json as NSData, fileName: fileName(result))
                //5 This uploads the ZIP file to RKBackendServerSample.
                uploadZipToRKBackendServer(path: zipPath)
            }
            else {
                print("Cannot convert to JSON")
            }
        }
        catch {
            print(error)
        }
    }
    
    func dictFromTaskResult(taskResult: ORKTaskResult, zipArchive: ZZArchive) -> [String : AnyObject]?{
        guard taskResult.results != nil else {
            return nil
        }
        var retDict : [String:AnyObject] = [:]
        //1 This stores taskRunId, start date, and end date
        retDict["taskRunUUID"] = taskResult.taskRunUUID.uuidString as AnyObject
        retDict["startDate"] = "\(taskResult.startDate)" as AnyObject
        retDict["endDate"] = "\(taskResult.endDate)" as AnyObject
        //2 This loops through the step results inside a task result in a for loop
        for result in taskResult.results! {
            if let stepResult = result as? ORKStepResult {
                print("Debug 1. Ebene: \(stepResult.identifier)")
                //3 This uses the dictFromStepResult method to convert step results to a dict
                retDict[stepResult.identifier] = dictFromStepResult(stepResult: stepResult, zipArchive: zipArchive) as AnyObject
            }
        }
        //4 This returns the generated dictionary enclosed in another dictionary with the task result's identifier as the key
        return [taskResult.identifier : retDict as AnyObject]
    }
    
    func dictFromStepResult (stepResult: ORKStepResult, zipArchive: ZZArchive) -> [String : AnyObject]?{
        guard stepResult.results != nil else {
            return nil
        }
        var retDict : [String:AnyObject] = [:]
        //1 This stores the start and end date of a step. This is useful to measure the amount of time that the participant spent on each step.
        retDict["startDate"] = "\(stepResult.startDate)" as AnyObject
        retDict["endDate"] = "\(stepResult.endDate)" as AnyObject
        //2 This loops through the results inside a step result in a loop. Unless it's a form step, the step result usually contains only one result inside of a step result.
        for result in stepResult.results! {
            //3 This checks whether the result is of ORKQuestionResult type. All the the survey responses will be of this type.
            if result is ORKQuestionResult {
                print("Debug 2. Ebene: \(result.identifier)")
                print("QuestionType: \((result as! ORKQuestionResult).questionType.stringValue()) - StringValue: \((result as! ORKQuestionResult).stringValue())")
                //4 This uses the custom stringValue enum methods to convert and ORKQuestionResult to a string
                retDict["\(result.identifier) (\((result as! ORKQuestionResult).questionType.stringValue()))"] = (result as! ORKQuestionResult).stringValue() as AnyObject
            }
            //4 This checks whether result is of the ORKFileResult type.
            else if result is ORKFileResult {
                let fileResult = result as! ORKFileResult
                //5 This sets the content type of the return dictionary from the file result.
                retDict["contentType"] = fileResult.contentType as AnyObject
                //6 This reads the path of the file from fileURL of the file result.
                if let filePath = fileResult.fileURL?.path {
                    //7 This writes the audio file to the ZIP archive. The zipArchive parameter in dictFromTaskResult and dictFromStepResult methods comes in handy.
                    do {
                        try writeToZip(archive: zipArchive, path: filePath)
                    }
                    catch {
                        print(error)
                    }
                    //8 This stores the filename in the key in the return dictionary. This key could indicate to the backend service to look for a file with the same name inside the ZIP archive.
                    retDict["filePath"] = (filePath as NSString).lastPathComponent as AnyObject
                }
            }
        }
        return retDict
    }
}

/*********************************************************************************/
//MARK: - Helper Extensions
/*********************************************************************************/

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

/*********************************************************************************/
//MARK: - Helper Methods
/*********************************************************************************/
func createUniqueTaskResultsFolder(uuid: NSUUID) throws -> String
{
    let path = (applicationDocumentsDirectory() as NSString).appendingPathComponent(uuid.uuidString)
    try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
    return path
}

func writeToZip(archive: ZZArchive, data: NSData, fileName: String) throws
{
    let entry = ZZArchiveEntry(fileName: fileName, compress: true) { error in
        return data as Data
    }
    try archive.updateEntries(archive.entries + [entry])
}

func writeToZip(archive: ZZArchive, path: String) throws
{
    if let data = NSData(contentsOfFile: path)
    {
        try writeToZip(archive: archive, data: data, fileName: (path as NSString).lastPathComponent)
    }
}

// send to backend server
func uploadZipToRKBackendServer(path: String)
{
    let data: NSData = NSData(contentsOfFile: path)!
    // 1: Localhost is used as the server address in RKBackendServerURL, which assumes that the app is run in the Xcode simulator. Change this to your Mac's IP address to run it in an iOS device.
    let RKBackendServerURL = "http://127.0.0.1:4567/upload/\((path as NSString).lastPathComponent)"
    //let RKBackendServerURL = "http://localhost:4567/upload/\((path as NSString).lastPathComponent)"
    // 2: This creates NSURLRequest to upload the ZIP file.
    let request = NSMutableURLRequest(url: NSURL(string: RKBackendServerURL)! as URL)
    request.httpMethod = "POST"
    request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    // 3: This uses the uploadTaskWithRequest method of NSURLSession to upload. Note that this implementation ignores all the complexities of networking. In the production environment, you are highly encouraged to follow the guidelines provided by Apple in the document.
    let task = URLSession.shared.uploadTask(with: request as URLRequest, from: data as Data) { (_, response, error) -> Void in
        if error == nil && (response! as! HTTPURLResponse).statusCode == 200
        {
            print("Successfully uploaded task results!")
        }
        else
        {
            print("Error: ", error as Any)
            print("Response: ", response.debugDescription)
        }
    }
    task.resume()
}

