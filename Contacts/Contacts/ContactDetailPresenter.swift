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
        interactor?.retrieveContactById(id: (contact?.id)!)
    }
    
    func showEditContact(forContact contact: ContactModel) {
        wireFrame?.presentEditContactScreen(from: view!, forContact: contact)
    }
    
    func showContactList() {
        wireFrame?.presentContactListScreen(from: view!)
    }
    
    func updateFavorite(id: Int) {
        interactor?.updateFavorite(id: id)
    }
    
    func getCurrentFavorite(id: Int) -> Bool {
        return (interactor?.getCurrentFavorite(id: id))!
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
