//
//  ContactDetailPresenter.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class ContactDetailPresenter: ContactDetailPresenterProtocol {
    
    weak var view: ContactDetailViewProtocol?
    var interactor: ContactDetailInteractorInputProtocol?
    var wireFrame: ContactDetailWireFrameProtocol?
    var contact: ContactModel?
    
    func viewDidLoad() {
        view?.showLoading()
        
        print("this is contact: \(contact)")
        
        interactor?.retrieveContactById(id: (contact?.id)!)
    }
    
    func showEditContact(forContact contact: ContactModel) {
        wireFrame?.presentEditContactScreen(from: view!, forContact: contact)
    }
}

extension ContactDetailPresenter: ContactDetailInteractorOutputProtocol {
    func didRetrieveDetail(_ contacts: [ContactModel]) {
        view?.hideLoading()
        view?.showContactDetail(forContact: contacts)
    }
    
    func onError(errorMessage: String) {
        view?.hideLoading()
        view?.showError(errorMessage: errorMessage)
    }
}
