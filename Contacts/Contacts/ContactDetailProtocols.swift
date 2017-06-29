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

