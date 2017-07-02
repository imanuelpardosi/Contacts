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
            print("check local data detail")
            
            if let contactById = try localDatamanager?.retrieveContactById(id: id) {
                let contactModelById = contactById.map() {
                    return ContactModel(id: Int($0.id), firstName: $0.firstName!.capitalized, lastName: $0.lastName!.capitalized, profilePicture: $0.profilePicture!, favorite: $0.favorite, url: $0.url!, email: $0.email!, phoneNumber: $0.phoneNumber!)
                }
                if contactModelById.isEmpty {
                    remoteDatamanager?.retrieveContactById(id: id)
                } else if (contactModelById.first?.phoneNumber.isEmpty)! {
                    remoteDatamanager?.retrieveContactById(id: id)
                } else {
                    presenter?.didRetrieveDetail(contactModelById)
                }
            } else {
                remoteDatamanager?.retrieveContactById(id: id)
            }
        } catch {
            presenter?.didRetrieveDetail([])
        }
    }
}

extension ContactDetailInteractor: ContactDetailRemoteDataManagerOutputProtocol {
    func onContactsRetrieved(_ contacts: [ContactModel]) {
        presenter?.didRetrieveDetail(contacts)
        
        for contactModel in contacts {
            do {
                try localDatamanager?.updateContact(id: contactModel.id, email: contactModel.email, phoneNumber: contactModel.phoneNumber)
            } catch {
                
            }
        }
    }
    
    func onError(errorMessage: String) {
        presenter?.onError(errorMessage: errorMessage)
    }
}
