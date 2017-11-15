//
//  DoSurveyHelperTest.swift
//  F14_ProjektArbeit_SurveysTests
//
//  Created by Till J. Ernst on 15.11.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import XCTest
import ZipZap
@testable import F14_ProjektArbeit_Surveys

class DoSurveyHelperTest: XCTestCase {
    
    let surveyTableView = DoSurveyTableViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWriteToZip() {
        let dataToZip = "Hello World"
        let fileName = "test.txt"
        do {
            //1 This creates a unique folder and ZIP archive to store the task result files.
            let uuid = NSUUID()
            let path = try createUniqueTaskResultsFolder(uuid: uuid)
            let zipPath = (path as NSString).appendingPathComponent("\(uuid.uuidString).zip")
            let zipArchive = try ZZArchive(url: NSURL(fileURLWithPath: zipPath) as URL, options: [ZZOpenOptionsCreateIfMissingKey : true])
            // data to be zipped
            let data = dataToZip.data(using: .utf8)
            // zip data
            try writeToZip(archive: zipArchive, data: data! as NSData, fileName: fileName)
            // unzip data and check fileName and content
            let zipEntry = zipArchive.entries[0]
            let takenFileName = zipEntry.fileName(withEncoding: String.Encoding.utf8.rawValue)
            XCTAssertEqual(fileName, takenFileName)
            let zipData = try zipEntry.newData()
            let dataAfterZip = String(data: zipData, encoding: String.Encoding.utf8)!
            XCTAssertEqual(dataToZip, dataAfterZip)
        }
        catch {
            print(error)
        }
        
    }
    
}
