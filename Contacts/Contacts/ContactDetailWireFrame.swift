//
//  ContactDetailWireFrame.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailWireFrame: ContactDetailWireFrameProtocol {
    
    func presentEditContactScreen(from view: ContactDetailViewProtocol, forContact contact: ContactModel) {
        let editContactViewController = AddEditContactWireFrame.createEditContactModule(forContact: contact)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(editContactViewController, animated: true)
        }
        //view.removeFromParentViewController()
    }
    
    func presentContactListScreen(from view: ContactDetailViewProtocol) {
        let contactListViewController = ContactListWireFrame.createContactListModule()
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(contactListViewController, animated: true)
        }
    }
    
    class func createContactDetailModule(forContact contact: ContactModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactDetailController")
        if let view = viewController as? ContactDetailView {
            let presenter: ContactDetailPresenterProtocol & ContactDetailInteractorOutputProtocol = ContactDetailPresenter()
            let interactor: ContactDetailInteractorInputProtocol & ContactDetailRemoteDataManagerOutputProtocol = ContactDetailInteractor()
            let localDataManager: ContactDetailLocalDataManagerInputProtocol = ContactDetailLocalDataManager()
            let remoteDataManager: ContactDetailRemoteDataManagerInputProtocol = ContactDetailRemoteDataManager()
            let wireFrame: ContactDetailWireFrameProtocol = ContactDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
