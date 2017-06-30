//
//  ContactListProtocol.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ContactListViewProtocol: class {
    var presenter: ContactListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showPosts(with contacts: [ContactModel])
    func showError()
    func showLoading()
    func hideLoading()
}

protocol ContactListWireFrameProtocol: class {
    static func createContactListModule() -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func presentContactDetailScreen(from view: ContactListViewProtocol, forContact contact: ContactModel)
}

protocol ContactListPresenterProtocol: class {
    var view: ContactListViewProtocol? { get set }
    var interactor: ContactListInteractorInputProtocol? { get set }
    var wireFrame: ContactListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showContactDetail(forContact contact: ContactModel)
}

protocol ContactListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveContacts(_ contacts: [ContactModel])
    func onError()
}

protocol ContactListInteractorInputProtocol: class {
    var presenter: ContactListInteractorOutputProtocol? { get set }
    var localDatamanager: ContactListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: ContactListRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveContactList()
}

protocol ContactListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ContactListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveContactList()
}

protocol ContactListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onContactsRetrieved(_ contacts: [ContactModel])
    func onError()
}

protocol ContactListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveContactList() throws -> [Contact]
    func retrieveContactById(id: Int) throws -> [Contact]
    func saveContact(id: Int, firstName: String, lastName: String, profilePicture: String, favorite: Bool, url: String, email: String, phoneNumber: String) throws
}
