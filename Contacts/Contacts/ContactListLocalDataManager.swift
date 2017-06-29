//
//  ContactListLocalDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import CoreData

class ContactListLocalDataManager: ContactListLocalDataManagerInputProtocol {
    
    func retrieveContactList() throws -> [Contact] {
        print("what : \(Contact.self)")
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Contact> = NSFetchRequest(entityName: String(describing: Contact.self))
        
        
        return try managedOC.fetch(request)
    }
    
    func savePost(id: Int, firstName: String, lastName: String, profilePicture: String, favorite: Bool, url: String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newContact = NSEntityDescription.entity(forEntityName: "Contact", in: managedOC) {
            let contact = Contact(entity: newContact, insertInto: managedOC)
            contact.id = Int32(id)
            contact.firstName = firstName
            contact.lastName = lastName
            contact.profilePicture = profilePicture
            contact.favorite = favorite
            contact.url = url
            try managedOC.save()
        }
        
        throw PersistenceError.couldNotSaveObject
    }
}
