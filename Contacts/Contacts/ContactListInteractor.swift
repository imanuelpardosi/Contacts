//
//  ContactListInteractor.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class ContactListInteractor: ContactListInteractorInputProtocol {
    weak var presenter: ContactListInteractorOutputProtocol?
    var localDatamanager: ContactListLocalDataManagerInputProtocol?
    var remoteDatamanager: ContactListRemoteDataManagerInputProtocol?
    
    func retrieveContactList() {
        do {
            print("check local data")
    
            if let contactList = try localDatamanager?.retrieveContactList() {
                let contactModelList = contactList.map() {
                    return ContactModel(id: Int($0.id), firstName: $0.firstName!.capitalized, lastName: $0.lastName!.capitalized, profilePicture: $0.profilePicture!, favorite: $0.favorite, url: $0.url!, email: $0.email!, phoneNumber: $0.phoneNumber!)
                }
                if contactModelList.isEmpty {
                    remoteDatamanager?.retrieveContactList()
                } else {
                    presenter?.didRetrieveContacts(contactModelList)
                }
            } else {
                remoteDatamanager?.retrieveContactList()
            }
        } catch {
            presenter?.didRetrieveContacts([])
        }
    }
}

extension ContactListInteractor: ContactListRemoteDataManagerOutputProtocol {
    func onContactsRetrieved(_ contacts: [ContactModel]) {
        presenter?.didRetrieveContacts(contacts)
        
        for contactModel in contacts {
            do {
                try localDatamanager?.saveContact(id: contactModel.id, firstName: contactModel.firstName.capitalized, lastName: contactModel.lastName.capitalized, profilePicture: contactModel.profilePicture, favorite: contactModel.favorite, url: contactModel.url, email: contactModel.email, phoneNumber: contactModel.phoneNumber)
            } catch {
                
            }
        }
    }
    
    func onError(errorMessage: String) {
        presenter?.onError(errorMessage: errorMessage)
    }
}
