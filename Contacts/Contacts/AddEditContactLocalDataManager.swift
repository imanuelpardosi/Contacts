//
//  AddEditContactLocalDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import CoreData

class AddEditContactLocalDataManager: AddEditContactLocalDataManagerInputProtocol {
    func addContact(id: Int, firstName: String, lastName: String, favorite: Bool, profilePicture: String, email: String, phoneNumber: String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        if let newContact = NSEntityDescription.entity(forEntityName: "Contact", in: managedOC) {
            let contact = Contact(entity: newContact, insertInto: managedOC)
            contact.id = Int32(id)
            contact.firstName = firstName
            contact.lastName = lastName
            contact.profilePicture = profilePicture
            contact.favorite = false
            contact.url = ""
            contact.email = email
            contact.phoneNumber = phoneNumber
            try managedOC.save()
        }
        
        throw PersistenceError.couldNotSaveObject

    }


    func updateContact(id: Int, firstName: String, lastName: String, favorite: Bool, profilePicture: String, email: String, phoneNumber :String) throws {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        let request: NSFetchRequest<Contact> = NSFetchRequest(entityName: String(describing: Contact.self))
        let predicate = NSPredicate(format: "id = \(id)")
        request.predicate = predicate
        
        do {
            let results = try managedOC.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Contact]
            if results.count != 0 {
                let managedObject = results[0]
                managedObject.setValue(firstName, forKey: "firstName")
                managedObject.setValue(lastName, forKey: "lastName")
                managedObject.setValue(favorite, forKey: "favorite")
                managedObject.setValue(profilePicture, forKey: "profilePicture")
                managedObject.setValue(email, forKey: "email")
                managedObject.setValue(phoneNumber, forKey: "phoneNumber")
                
                try managedOC.save()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        throw PersistenceError.couldNotSaveObject
    }
}
