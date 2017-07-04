//
//  AddEditContactProtocols.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

protocol AddEditContactViewProtocol: class {
    var presenter: AddEditContactPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showAddEditContact(forContact contact: ContactModel)
    func showError(errorMessage: String)
    func showLoading()
    func hideLoading()
}

protocol AddEditContactWireFrameProtocol: class {
    static func createAddContactModule(forContact contact: ContactModel, method: String) -> UIViewController
    static func createEditContactModule(forContact contact: ContactModel, method: String) -> UIViewController
    
    func presentContactDetailScreen(from view: AddEditContactView, forContact contact: ContactModel)
}

protocol AddEditContactPresenterProtocol: class {
    var view: AddEditContactViewProtocol? { get set }
    var interactor: AddEditContactInteractorInputProtocol? { get set }
    var wireFrame: AddEditContactWireFrameProtocol? { get set }
    var contact: ContactModel? { get set }
    var method: String? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showContactDetail(forContact contact: ContactModel)
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
    func addContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
}

protocol AddEditContactInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func showAddEditContact(_ contacts: [ContactModel])
    func onError(errorMessage: String)
    func didAddEditContact(_ contacts: [ContactModel])
}

protocol AddEditContactInteractorInputProtocol: class {
    var presenter: AddEditContactInteractorOutputProtocol? { get set }
    var localDatamanager: AddEditContactLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: AddEditContactRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func addContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
}

protocol AddEditContactRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: AddEditContactRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    //func retrieveContactById(id: Int)
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
    func addContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String)
}

protocol AddEditContactRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    //func onContactsRetrieved(_ contacts: [ContactModel])
    func onError(errorMessage: String)
    func onContactEdited(_ contacts: [ContactModel])
    func onContactAdded(_ contacts: [ContactModel])
}

protocol AddEditContactLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func addContact(id: Int, firstName: String, lastName: String, favorite: Bool, profilePicture: String, email: String, phoneNumber: String) throws
    func updateContact(id: Int, firstName: String, lastName: String, favorite: Bool, profilePicture: String, email: String, phoneNumber: String) throws
}
