//
//  AddEditContactView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/2/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactView: UIViewController {
    
    var presenter: AddEditContactPresenterProtocol?
    var hud: HUD = HUD()
    var uiViewUtilities: UIViewUtilities = UIViewUtilities()
    var colorUtilities: ColorUtilities = ColorUtilities()
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = doneItem
        self.navigationController?.navigationBar.tintColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func doneTapped() {
        showLoading()
        if presenter?.method == "Edit" {
            presenter?.updateContact(id: id, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: mobile.text!, email: email.text!)
        } else {
            presenter?.addContact(id: id, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: mobile.text!, email: email.text!)
        }
        
    }
}

extension AddEditContactView: AddEditContactViewProtocol {
    
    func showAddEditContact(forContact contact: ContactModel) {
        id = contact.id
        firstName.text = contact.firstName
        lastName.text = contact.lastName
        mobile.text = contact.phoneNumber
        email.text = contact.email
    }
    
    func showError(errorMessage: String) {
        hud.showError(message: errorMessage, uiView: self)
    }
    
    func showLoading() {
        hud.showActivityIndicator(uiView: self.view)
    }
    
    func hideLoading() {
        hud.hideActivityIndicator(uiView: self.view)
    }
}
