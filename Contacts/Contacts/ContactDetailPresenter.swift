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
    var wireFrame: ContactDetailWireFrameProtocol?
    var contact: ContactModel?
    
    func viewDidLoad() {
        view?.showContactDetail(forContact: contact!)
    }
    
}

