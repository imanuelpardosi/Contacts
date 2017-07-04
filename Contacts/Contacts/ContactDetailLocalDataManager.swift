//
//  ContactDetailLocalDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/30/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import CoreData

class ContactDetailLocalDataManager: ContactDetailLocalDataManagerInputProtocol {
    func updateFavorite(id: Int) throws {
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
                
                let contact = try retrieveContactById(id: id)
                managedObject.setValue(!(contact.first?.favorite)!, forKey: "favorite")
                
                try managedOC.save()
                
                print(try retrieveContactById(id: id))
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        throw PersistenceError.couldNotSaveObject
    }


    func retrieveContactById(id: Int) throws -> [Contact] {
        guard let managedOC = CoreDataStore.managedObjectContext else {
            throw PersistenceError.managedObjectContextNotFound
        }
        
        let request: NSFetchRequest<Contact> = NSFetchRequest(entityName: String(describing: Contact.self))
        let predicate = NSPredicate(format: "id = \(id)")
        request.predicate = predicate
        
        do {
            let results = try managedOC.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Contact]
            return results
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }
    
    func updateContact(id: Int, email: String, phoneNumber :String) throws {
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
