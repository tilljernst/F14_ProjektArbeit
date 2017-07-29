//
//  AppHandlerTest.swift
//  F14_ProjektArbeit_Surveys
//
//  Created by Till J. Ernst on 28.06.17.
//  Copyright © 2017 Till J. Ernst. All rights reserved.
//

import XCTest
@testable import F14_ProjektArbeit_Surveys

class UserDefaultHandlerTest: XCTestCase {
    
    
    let userDefaultHandler = UserDefaultHandler()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.userDefaultHandler.cleanUpUserDefaults()
        super.tearDown()
    }
    
    func testIsUserConfigurationSet() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        // after cleaning up UserDefaults, func returns false
        self.userDefaultHandler.cleanUpUserDefaults()
        XCTAssertFalse(self.userDefaultHandler.isUserConfigurationSet())
        // after init UserDefaults, func should still return false (value "" is still not a valid user configuration)
        self.userDefaultHandler.initUserDefaults()
        XCTAssertFalse(self.userDefaultHandler.isUserConfigurationSet())
        for key in self.userDefaultHandler.userDefaultKeys {
            defaults.set(value, forKey: key.rawValue)
        }
        XCTAssertTrue(self.userDefaultHandler.isUserConfigurationSet())
    }
    
    func testCleanUpUserDefaults() {
        self.userDefaultHandler.cleanUpUserDefaults()
        let defaults = UserDefaults.standard
        for key in self.userDefaultHandler.userDefaultKeys {
            XCTAssertNil(defaults.string(forKey: key.rawValue))
        }
    }
    
    func testInitUserDefaults() {
        self.userDefaultHandler.initUserDefaults()
        let defaults = UserDefaults.standard
        for key in self.userDefaultHandler.userDefaultKeys {
            XCTAssert(((defaults.object(forKey: key.rawValue) as? NSString) == ""))
        }
        self.userDefaultHandler.cleanUpUserDefaults()
    }
    
    func testSetUserDefaultsValue() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        for key in self.userDefaultHandler.userDefaultKeys {
            self.userDefaultHandler.setUserDefaultsValue(userKey: key.rawValue, value: value)
            XCTAssertEqual(defaults.string(forKey: key.rawValue), value)
        }
    }
    
    func testGetUserDefaultsValue() {
        let defaults = UserDefaults.standard
        let value = "testvalue"
        for key in self.userDefaultHandler.userDefaultKeys {
            defaults.set(value, forKey: key.rawValue)
            XCTAssertEqual(self.userDefaultHandler.getUserDefaultsValue(userKey: key.rawValue), value)
        }
        self.userDefaultHandler.cleanUpUserDefaults()
        for key in self.userDefaultHandler.userDefaultKeys {
            XCTAssertNil(self.userDefaultHandler.getUserDefaultsValue(userKey: key.rawValue))
        }
    }
    
    func testSetConfigurationDate() {
        let timestamp = NSDate()
        self.userDefaultHandler.setConfigurationDate(date: timestamp)
        
        let returnUserDefaultValue = self.userDefaultHandler.getUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate))
        
        let dateFormatter = self.userDefaultHandler.getConfigDateFormatter()
        
        let testDate = dateFormatter.string(from: timestamp as Date)
        
        XCTAssertEqual(returnUserDefaultValue, testDate)
        
        self.userDefaultHandler.cleanUpUserDefaults()
    }
    
    func testRetrieveConfigurationDate() {
        let timestamp = NSDate()
        
        let dateFormatter = self.userDefaultHandler.getConfigDateFormatter()
        
        let testDate = dateFormatter.string(from: timestamp as Date)
        
        self.userDefaultHandler.setUserDefaultsValue(userKey: String(describing:UserDefaultKey.configurationDate), value: testDate)
        
        let retrievedDate = self.userDefaultHandler.retrieveConfigurationDate()
        
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .hour) == .orderedSame)
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .day) == .orderedSame)
        XCTAssertTrue(NSCalendar.current.compare(timestamp as Date, to: retrievedDate! as Date,
                                                 toGranularity: .year) == .orderedSame)
        
        self.userDefaultHandler.cleanUpUserDefaults()
    }
    
    
}
