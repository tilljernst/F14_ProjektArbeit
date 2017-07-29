//
//  AppHandlerTest.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 28.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import XCTest
@testable import F14_ProjektArbeit_Surveys

class AppHandlerTest: XCTestCase {
    
    
    let appHandler = AppHandler()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.appHandler.cleanUpUserDefaults()
        super.tearDown()
    }
    
    func testIsUserConfigurationSet() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        // after cleaning up UserDefaults, func returns false
        self.appHandler.cleanUpUserDefaults()
        XCTAssertFalse(self.appHandler.isUserConfigurationSet())
        // after init UserDefaults, func should still return false (value "" is still not a valid user configuration)
        self.appHandler.initUserDefaults()
        XCTAssertFalse(self.appHandler.isUserConfigurationSet())
        for key in self.appHandler.userDefaultKeys {
            defaults.set(value, forKey: key.rawValue)
        }
        XCTAssertTrue(self.appHandler.isUserConfigurationSet())
    }
    
    func testCleanUpUserDefaults() {
        self.appHandler.cleanUpUserDefaults()
        let defaults = UserDefaults.standard
        for key in self.appHandler.userDefaultKeys {
            XCTAssertNil(defaults.string(forKey: key.rawValue))
        }
    }
    
    func testInitUserDefaults() {
        self.appHandler.initUserDefaults()
        let defaults = UserDefaults.standard
        for key in self.appHandler.userDefaultKeys {
            XCTAssert(((defaults.object(forKey: key.rawValue) as? NSString) == ""))
        }
        self.appHandler.cleanUpUserDefaults()
    }
    
    func testSetUserDefaultsValue() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        for key in self.appHandler.userDefaultKeys {
            self.appHandler.setUserDefaultsValue(userKey: key.rawValue, value: value)
            XCTAssertEqual(defaults.string(forKey: key.rawValue), value)
        }
    }
    
    func testGetUserDefaultsValue() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        for key in self.appHandler.userDefaultKeys {
            defaults.set(value, forKey: key.rawValue)
            XCTAssertEqual(self.appHandler.getUserDefaultsValue(userKey: key.rawValue), value)
        }
        self.appHandler.cleanUpUserDefaults()
        for key in self.appHandler.userDefaultKeys {
            XCTAssertNil(self.appHandler.getUserDefaultsValue(userKey: key.rawValue))
        }
    }
    
    func testSetConfigurationDate() {
        let timestamp = NSDate()
        self.appHandler.setConfigurationDate(date: timestamp)
        
        let returnUserDefaultValue = self.appHandler.getUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate))
        
        let dateFormatter = self.appHandler.getConfigDateFormatter()
        
        let testDate = dateFormatter.string(from: timestamp as Date)
        
        XCTAssertEqual(returnUserDefaultValue, testDate)
        
        self.appHandler.cleanUpUserDefaults()
    }
    
    func testRetrieveConfigurationDate() {
        let timestamp = NSDate()
        
        let dateFormatter = self.appHandler.getConfigDateFormatter()
        
        let testDate = dateFormatter.string(from: timestamp as Date)
        
        self.appHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: testDate)
        
        let retrievedDate = self.appHandler.retrieveConfigurationDate()
        
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .hour) == .orderedSame)
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .day) == .orderedSame)
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .year) == .orderedSame)
        
        self.appHandler.cleanUpUserDefaults()
    }
    
    
}
