//
//  ContactListPresenter.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

class ContactListPresenter: ContactListPresenterProtocol {
    weak var view: ContactListViewProtocol?
    var interactor: ContactListInteractorInputProtocol?
    var wireFrame: ContactListWireFrameProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        
        interactor?.retrieveContactList()
    }
    
    func showContactDetail(forContact contact: ContactModel) {
        wireFrame?.presentContactDetailScreen(from: view!, forContact: contact)
    }
}

extension ContactListPresenter: ContactListInteractorOutputProtocol {
    func didRetrieveContacts(_ contacts: [ContactModel]) {
        view?.hideLoading()
        view?.showPosts(with: contacts)
    }
    
    func onError(errorMessage: String) {
        view?.hideLoading()
        view?.showError(errorMessage: errorMessage)
    }
}
