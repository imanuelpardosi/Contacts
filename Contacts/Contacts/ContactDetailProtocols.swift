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
    func showContactDetail(forContact contact: [ContactModel])
    func showError(errorMessage: String)
    func showLoading()
    func hideLoading()
}

protocol ContactDetailWireFrameProtocol: class {
    static func createContactDetailModule(forContact contact: ContactModel) -> UIViewController
    
    func presentEditContactScreen(from view: ContactDetailViewProtocol, forContact contact: ContactModel)
    func presentContactListScreen(from view: ContactDetailViewProtocol)
}

protocol ContactDetailPresenterProtocol: class {
    var view: ContactDetailViewProtocol? { get set }
    var interactor: ContactDetailInteractorInputProtocol? { get set }
    var wireFrame: ContactDetailWireFrameProtocol? { get set }
    var contact: ContactModel? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showEditContact(forContact contact: ContactModel)
    func showContactList()

}

protocol ContactDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveDetail(_ contacts: [ContactModel])
    func onError(errorMessage: String)
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
    func onError(errorMessage: String)
}

protocol ContactDetailLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveContactById(id: Int) throws -> [Contact]
    func updateContact(id: Int, email: String, phoneNumber: String) throws
}
