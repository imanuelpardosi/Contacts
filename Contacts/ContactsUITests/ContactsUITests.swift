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
    
    func testShowContactList() {
        let app = XCUIApplication()
        let count = app.tables.cells.count
        let btnAdd = app.buttons["Add"]
        let btnGroups = app.buttons["Groups"]
        
        XCTAssert(count > 0)
        XCTAssertTrue(btnAdd.exists)
        XCTAssertTrue(btnGroups.exists)
    }
    
    func testSwipeContactList() {
        let app = XCUIApplication()
        app.tables.element.swipeUp()
    }
    
    func testShowContactDetail() {
        let app = XCUIApplication()
        
        let lblName = app.staticTexts.element(matching: .any, identifier: "name")
        let btnEdit = app.buttons["Edit"]
        let btnCancel = app.buttons["Cancel"]
        let btnMessage = app.buttons["message"]
        let btnCall = app.buttons["call"]
        let btnEmail = app.buttons["email"]
        let btnFavourite = app.buttons["favourite"]
        
        app.cells.element(boundBy: 4).tap()
        
        XCTAssertTrue(lblName.exists)
        XCTAssertTrue(btnEdit.exists)
        XCTAssertTrue(btnCancel.exists)
        XCTAssertTrue(btnMessage.exists)
        XCTAssertTrue(btnCall.exists)
        XCTAssertTrue(btnEmail.exists)
        XCTAssertTrue(btnFavourite.exists)
    }
    
    func testShowAddContact() {
        let app = XCUIApplication()
        
        let txtFieldFirstName = app.textFields["firstName"]
        let txtFieldLastName = app.textFields["lastName"]
        let txtFieldMobile = app.textFields["mobile"]
        let txtFieldEmail = app.textFields["email"]
        let btnDone = app.buttons["Done"]
        let btnCancel = app.buttons["Cancel"]
        
        app.buttons["Add"].tap()
        
        XCTAssertTrue(txtFieldFirstName.exists)
        XCTAssertTrue(txtFieldLastName.exists)
        XCTAssertTrue(txtFieldMobile.exists)
        XCTAssertTrue(txtFieldEmail.exists)
        XCTAssertTrue(btnDone.exists)
        XCTAssertTrue(btnCancel.exists)
        
        XCTAssertNotEqual(txtFieldFirstName.label, "Imanuel")
        XCTAssertNotEqual(txtFieldLastName.label, "Pardosi")
        XCTAssertEqual(txtFieldMobile.label, "")
        XCTAssertEqual(txtFieldEmail.label, "")
    }
    
    func testAddContact() {
        let app = XCUIApplication()
        
        let txtFieldFirstName = app.textFields["firstName"]
        let txtFieldLastName = app.textFields["lastName"]
        let txtFieldMobile = app.textFields["mobile"]
        let txtFieldEmail = app.textFields["email"]
        let btnDone = app.buttons["Done"]
        let btnCancel = app.buttons["Cancel"]
        let topView = app.otherElements["topView"]
        
        app.buttons["Add"].tap()
        
        XCTAssertTrue(txtFieldFirstName.exists)
        XCTAssertTrue(txtFieldLastName.exists)
        XCTAssertTrue(txtFieldMobile.exists)
        XCTAssertTrue(txtFieldEmail.exists)
        XCTAssertTrue(btnDone.exists)
        XCTAssertTrue(btnCancel.exists)
        
        txtFieldFirstName.tap()
        txtFieldFirstName.typeText("First")
        
        topView.tap()
        txtFieldLastName.tap()
        txtFieldLastName.typeText("Last")
        
        topView.tap()
        txtFieldMobile.tap()
        txtFieldMobile.typeText("+6282256789300")
        
        topView.tap()
        txtFieldEmail.tap()
        txtFieldEmail.typeText("first@last.com")
        topView.tap()
        
        app.buttons["Done"].tap()
    }
    
    func testUpdateContact() {
        let app = XCUIApplication()
        
        let txtFieldFirstName = app.textFields["firstName"]
        let txtFieldLastName = app.textFields["lastName"]
        let txtFieldMobile = app.textFields["mobile"]
        let txtFieldEmail = app.textFields["email"]
        let btnDone = app.buttons["Done"]
        let btnCancel = app.buttons["Cancel"]
        let btnEdit = app.buttons["Edit"]
        let name = app.staticTexts.element(matching: .any, identifier: "name")
        let topView = app.otherElements["topView"]
        
        app.cells.element(boundBy: 5).tap()
        
        XCTAssertTrue(btnEdit.exists)
        
        app.buttons["Edit"].tap()
        
        XCTAssertTrue(txtFieldFirstName.exists)
        XCTAssertTrue(txtFieldLastName.exists)
        XCTAssertTrue(txtFieldMobile.exists)
        XCTAssertTrue(txtFieldEmail.exists)
        XCTAssertTrue(btnDone.exists)
        XCTAssertTrue(btnCancel.exists)
        
        txtFieldFirstName.clearAndEnterText(text: "Risa")
        topView.tap()
        txtFieldLastName.clearAndEnterText(text: "Rasi")
        
        app.buttons["Done"].tap()
        
        XCTAssertEqual(name.label, "Risa Rasi")
    }
    
    func testUpdateFavourite() {
        let app = XCUIApplication()
        
        
        let lblName = app.staticTexts.element(matching: .any, identifier: "name")
        let btnEdit = app.buttons["Edit"]
        let btnCancel = app.buttons["Cancel"]
        let btnMessage = app.buttons["message"]
        let btnCall = app.buttons["call"]
        let btnEmail = app.buttons["email"]
        let btnFavourite = app.buttons["favourite"]
        
        app.cells.element(boundBy: 4).tap()
        
        XCTAssertTrue(lblName.exists)
        XCTAssertTrue(btnEdit.exists)
        XCTAssertTrue(btnCancel.exists)
        XCTAssertTrue(btnMessage.exists)
        XCTAssertTrue(btnCall.exists)
        XCTAssertTrue(btnEmail.exists)
        XCTAssertTrue(btnFavourite.exists)
        
        btnFavourite.tap()
    }
}

extension XCUIElement {
    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        
        self.tap()
        
        let deleteString = stringValue.characters.map { _ in XCUIKeyboardKeyDelete }.joined(separator: "")
        
        self.typeText(deleteString)
        self.typeText(text)
    }
}
