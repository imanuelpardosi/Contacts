//
//  AddEditContactWireFrame.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactWireFrame: AddEditContactWireFrameProtocol {
    
    func presentContactDetailScreen(from view: AddEditContactView, forContact contact: ContactModel) {
        //let contactDetailViewController = ContactDetailWireFrame.createContactDetailModule(forContact: contact)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.popViewController(animated: true)
        }
    }
    
    class func createAddContactModule(forContact contact: ContactModel, method: String) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AddEditContactView")
        if let view = viewController as? AddEditContactView {
            let presenter: AddEditContactPresenterProtocol & AddEditContactInteractorOutputProtocol = AddEditContactPresenter()
            let interactor: AddEditContactInteractorInputProtocol & AddEditContactRemoteDataManagerOutputProtocol = AddEditContactInteractor()
            let localDataManager: AddEditContactLocalDataManagerInputProtocol = AddEditContactLocalDataManager()
            let remoteDataManager: AddEditContactRemoteDataManagerInputProtocol = AddEditContactRemoteDataManager()
            let wireFrame: AddEditContactWireFrameProtocol = AddEditContactWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.method = method
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return viewController
        }
        return UIViewController()
    }
    
    class func createEditContactModule(forContact contact: ContactModel, method: String) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "AddEditContactView")
        if let view = viewController as? AddEditContactView {
            let presenter: AddEditContactPresenterProtocol & AddEditContactInteractorOutputProtocol = AddEditContactPresenter()
            let interactor: AddEditContactInteractorInputProtocol & AddEditContactRemoteDataManagerOutputProtocol = AddEditContactInteractor()
            let localDataManager: AddEditContactLocalDataManagerInputProtocol = AddEditContactLocalDataManager()
            let remoteDataManager: AddEditContactRemoteDataManagerInputProtocol = AddEditContactRemoteDataManager()
            let wireFrame: AddEditContactWireFrameProtocol = AddEditContactWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.method = method
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
