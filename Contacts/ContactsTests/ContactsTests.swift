//
//  ContactsTests.swift
//  ContactsTests
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import XCTest
@testable import Contacts

class ContactsTests: XCTestCase {
    
    var wireFrame: ContactListWireFrame!
    var interactor: ContactDetailInteractor!
    var view: ContactListView!
    let contactListLocalData = ContactListLocalDataManager()
    let addEditContactLocalData = AddEditContactLocalDataManager()
    let contactDetailLocalData = ContactDetailLocalDataManager()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        wireFrame = ContactListWireFrame()
        interactor = ContactDetailInteractor()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGoToContactList() {
        let contactList = ContactListWireFrame.createContactListModule()
        
        XCTAssert(contactList.childViewControllers.capacity != 0)
    }
    
    func testUpdateLocalData() {
        var contact: [Contact]
        do {
            try addEditContactLocalData.updateContact(id: 392, firstName: "imanuel", lastName: "pardosi", favorite: false, profilePicture: "path", email: "nuel.pard@gmail.co", phoneNumber: "+621234568394")
            
            contact = try contactListLocalData.retrieveContactById(id: 392)
            XCTAssertEqual(contact.first?.id, 392)
            XCTAssertEqual(contact.first?.firstName, "imanuel")
        } catch let err {
            print("err: \(err)")
        }
    }
    
    func testRetrieveContactById() {
        var contact: [Contact]
        do {
            contact = try contactListLocalData.retrieveContactById(id: 392)
            
            XCTAssertEqual(contact.first?.id, 392)
            
        } catch let err {
            print("err: \(err)")
        }
    }
    
    func testRetrieveAllContact() {
        var contact: [Contact]
        do {
            contact = try contactListLocalData.retrieveContactList()
            
            XCTAssertNotNil(contact.count)
        } catch let err {
            print("err: \(err)")
        }
    }
    
    func testUpdateFavorite() {
        var contact: [Contact]
        do {
            contact = try contactListLocalData.retrieveContactById(id: 392)
            let currentFav = contact.first?.favorite
            try contactDetailLocalData.updateFavorite(id: 392)
            
            XCTAssertNotEqual(currentFav, !currentFav!)
        } catch let err {
            print("err: \(err)")
        }
    }
}

