//
//  ContactsUITests.swift
//  ContactsUITests
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import XCTest

class ContactsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        let app = XCUIApplication()
//        let table = app.tables.element(boundBy: 0)
//        debugPrint(table.cells.count)
//        XCTAssertNotEqual(table.cells.count, 0)
//        
//        let tablesQuery = app.tables
//        let cellQuery = tablesQuery.cells.containing(.staticText, identifier: "contactCell")
//        let cell = cellQuery.children(matching: .staticText)
//        let cellElement = cell.element
//        cellElement.tap()
        
//        let app = XCUIApplication()
//        app.navigationBars["Contact"].buttons["Add"].tap()
//        app.navigationBars["Contacts.AddEditContactView"].tap()
//        app.alerts["Error"].buttons["Close"].tap()
        
//        let tableElement = tablesQuery.element
//        tableElement.swipeUp()
        
        let app = XCUIApplication()
        app.buttons["Add"].tap()
    }
    
}
