//
//  File.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class AddEditContactPresenter: AddEditContactPresenterProtocol {
    weak var view: AddEditContactViewProtocol?
    var interactor: AddEditContactInteractorInputProtocol?
    var wireFrame: AddEditContactWireFrameProtocol?
    var contact: ContactModel?
    var method: String?
    
    func viewDidLoad() {
        if method == "Edit" {
            view?.showAddEditContact(forContact: contact!)
        }
    }
    
    func showContactDetail(forContact contact: ContactModel) {
        wireFrame?.presentContactDetailScreen(from: view! as! AddEditContactView, forContact: contact)
    }
    
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        interactor?.updateContact(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
    }
    
    func addContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        interactor?.addContact(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
    }
}

extension AddEditContactPresenter: AddEditContactInteractorOutputProtocol {
    func showAddEditContact(_ contacts: [ContactModel]) {
        view?.hideLoading()
    }
    
    func didAddEditContact(_ contacts: [ContactModel]) {
        contact = contacts.first
        view?.hideLoading()
        wireFrame?.presentContactDetailScreen(from: view! as! AddEditContactView, forContact: contact!)
    }
    
    func onError(errorMessage: String) {
        view?.hideLoading()
        view?.showError(errorMessage: errorMessage)
    }
}
