//
//  ContactListWireFrame.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactListWireFrame: ContactListWireFrameProtocol {
    func presentAddContactScreen(from view: ContactListViewProtocol) {
        let contact: ContactModel = ContactModel()
        let addContactViewController = AddEditContactWireFrame.createAddContactModule(forContact: contact, method: "Add")
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(addContactViewController, animated: true)
        }

    }

    
    func presentContactDetailScreen(from view: ContactListViewProtocol, forContact contact: ContactModel) {
        let contactDetailViewController = ContactDetailWireFrame.createContactDetailModule(forContact: contact)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(contactDetailViewController, animated: true)
        }
    }
    
    class func createContactListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "ContactsNavigationController")
        
        if let view = navController.childViewControllers.first as? ContactListView {
            let presenter: ContactListPresenterProtocol & ContactListInteractorOutputProtocol = ContactListPresenter()
            let interactor: ContactListInteractorInputProtocol & ContactListRemoteDataManagerOutputProtocol = ContactListInteractor()
            let localDataManager: ContactListLocalDataManagerInputProtocol = ContactListLocalDataManager()
            let remoteDataManager: ContactListRemoteDataManagerInputProtocol = ContactListRemoteDataManager()
            let wireFrame: ContactListWireFrameProtocol = ContactListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }    
}
