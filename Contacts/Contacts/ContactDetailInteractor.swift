//
//  ContctDetailInteractor.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/30/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class ContactDetailInteractor: ContactDetailInteractorInputProtocol {
    weak var presenter: ContactDetailInteractorOutputProtocol?
    var localDatamanager: ContactDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: ContactDetailRemoteDataManagerInputProtocol?
    
    func retrieveContactById(id: Int) {
        do {
            print("check local data")
            
            if let contactById = try localDatamanager?.retrieveContactById(id: id) {

                if contactById.isEmpty {
                    print("empty")
                } else if (contactById.first?.phoneNumber?.isEmpty)! {
                    print("contactnya: \(contactById.first?.phoneNumber)")
                }
            }
            
            
//            if let contactList = try localDatamanager?.retrieveContactList() {
//                let contactModelList = contactList.map() {
//                    return ContactModel(id: Int($0.id), firstName: $0.firstName!.capitalized, lastName: $0.lastName!.capitalized, profilePicture: $0.profilePicture!, favorite: $0.favorite, url: $0.url!, email: $0.email!, phoneNumber: $0.phoneNumber!)
//                }
//                if contactModelList.isEmpty {
//                    remoteDatamanager?.retrieveContactList()
//                } else {
//                    presenter?.didRetrieveContacts(contactModelList)
//                }
//            } else {
//                remoteDatamanager?.retrieveContactList()
//            }
        } catch {
            presenter?.didRetrieveContacts([])
        }
    }
}

extension ContactDetailInteractor: ContactDetailRemoteDataManagerOutputProtocol {
    func onContactsRetrieved(_ contacts: [ContactModel]) {
        presenter?.didRetrieveContacts(contacts)
        
        for contactModel in contacts {
            do {
                try localDatamanager?.updateContact(id: contactModel.id, email: contactModel.email, phoneNumber: contactModel.phoneNumber)
            } catch {
                
            }
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}
