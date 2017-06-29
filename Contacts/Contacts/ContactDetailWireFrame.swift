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
    
    class func createContactDetailModule(forContact contact: ContactModel) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "ContactDetailController")
        if let view = viewController as? ContactDetailView {
            let presenter: ContactDetailPresenterProtocol = ContactDetailPresenter()
            let wireFrame: ContactDetailWireFrameProtocol = ContactDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.contact = contact
            presenter.wireFrame = wireFrame
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
