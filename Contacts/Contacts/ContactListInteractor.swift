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
                    return ContactModel(id: Int($0.id), firstName: $0.firstName!.capitalized, lastName: $0.lastName!.capitalized, profilePicture: $0.profilePicture!, favorite: $0.favorite, url: $0.url!)
                }
                if contactModelList.isEmpty {
                    remoteDatamanager?.retreaveContactList()
                } else {
                    presenter?.didRetreaveContacts(contactModelList)
                }
            } else {
                remoteDatamanager?.retreaveContactList()
            }
        } catch {
            presenter?.didRetreaveContacts([])
        }
    }
}

extension ContactListInteractor: ContactListRemoteDataManagerOutputProtocol {
    func onContactsRetrieved(_ contacts: [ContactModel]) {
        presenter?.didRetreaveContacts(contacts)
        
        for contactModel in contacts {
            do {
                try localDatamanager?.savePost(id: contactModel.id, firstName: contactModel.firstName.capitalized, lastName: contactModel.lastName.capitalized, profilePicture: contactModel.profilePicture, favorite: contactModel.favorite, url: contactModel.url)
            } catch {
                
            }
        }
    }
    
    func onError() {
        presenter?.onError()
    }
}
