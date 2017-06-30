//
//  ContactDetailProtocols.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailViewProtocol: class {
    var presenter: ContactDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showContactDetail(forContact contact: ContactModel)
}

protocol ContactDetailWireFrameProtocol: class {
    static func createContactDetailModule(forContact contact: ContactModel) -> UIViewController
}

protocol ContactDetailPresenterProtocol: class {
    var view: ContactDetailViewProtocol? { get set }
    var wireFrame: ContactDetailWireFrameProtocol? { get set }
    var contact: ContactModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ContactDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: [ContactModel])
    func onError()
}


protocol ContactDetailInteractorInputProtocol: class {
    var presenter: ContactDetailInteractorOutputProtocol? { get set }
    var localDatamanager: ContactDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ContactDetailRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveContactById(id: Int)
}

protocol ContactDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ContactDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactById(id: Int)
}

protocol ContactDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: [ContactModel])
    func onError()
}

protocol ContactDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveContactById(id: Int) throws -> [Contact]
    func updateContact(id: Int, email: String, phoneNumber: String) throws
}
