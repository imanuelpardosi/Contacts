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
    
    func viewDidLoad() {
        view?.showAddEditContact(forContact: contact!)
    }
    
    func showContactDetail(forContact contact: ContactModel) {
        wireFrame?.presentContactDetailScreen(from: view! as! AddEditContactView, forContact: contact)
    }
    
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        interactor?.updateContact(id: id, firstName: firstName, lastName: lastName, phoneNumber: phoneNumber, email: email)
    }
}

extension AddEditContactPresenter: AddEditContactInteractorOutputProtocol {
    func showAddEditContact(_ contacts: [ContactModel]) {
        view?.hideLoading()
        //view?.showAddEditContact(forContact: contacts)
    }
    
    func onError(errorMessage: String) {
        view?.hideLoading()
        view?.showError(errorMessage: errorMessage)
    }
    
    func didEditContact(_ contacts: [ContactModel]) {
        view?.hideLoading()
        wireFrame?.presentContactDetailScreen(from: view! as! AddEditContactView, forContact: contact!)
    }
}
