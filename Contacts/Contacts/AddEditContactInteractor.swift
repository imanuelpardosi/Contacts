//
//  AddEditContactInteractor.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class AddEditContactInteractor: AddEditContactInteractorInputProtocol {
    weak var presenter: AddEditContactInteractorOutputProtocol?
    var localDatamanager: AddEditContactLocalDataManagerInputProtocol?
    var remoteDatamanager: AddEditContactRemoteDataManagerInputProtocol?
    
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        remoteDatamanager?.updateContact(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
    }
}

extension AddEditContactInteractor: AddEditContactRemoteDataManagerOutputProtocol {
    
    func onError(errorMessage: String) {
        presenter?.onError(errorMessage: errorMessage)
    }
    
    func onContactEdited(_ contacts: [ContactModel]) {
        presenter?.didEditContact(contacts)
        for contactModel in contacts {
            do {
                try localDatamanager?.updateContact(id: contactModel.id, firstName: contactModel.firstName, lastName: contactModel.lastName, favorite: contactModel.favorite, profilePicture: contactModel.profilePicture, email: contactModel.email, phoneNumber: contactModel.phoneNumber)
            } catch {
                
            }
        }
    }
}
