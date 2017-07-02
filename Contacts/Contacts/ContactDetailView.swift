//
//  ContactDetailView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailView: UIViewController {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var btnHeightConstraint: NSLayoutConstraint!
    
    var hud: HUD = HUD()
    var uiViewUtilities: UIViewUtilities = UIViewUtilities()
    var colorUtilities: ColorUtilities = ColorUtilities()
    var presenter: ContactDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = "Contact"
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItem = edit
        self.navigationController?.navigationBar.tintColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        btnHeightConstraint.constant = btnMessage.frame.width
        uiViewUtilities.circleView(views: profilePicture, btnMessage, btnCall, btnEmail, btnFavorite)
    }
    
    func editTapped(sender: UIBarButtonItem) {
        print("Edit")
    }

    @IBAction func btnMessageOnClick(_ sender: Any) {
        
    }
    
    @IBAction func btnCallOnClick(_ sender: Any) {
        
    }
    
    @IBAction func btnEmailOnClick(_ sender: Any) {
        
    }
    
    @IBAction func btnFavoriteOnClick(_ sender: Any) {
        
    }
}

extension ContactDetailView: ContactDetailViewProtocol {
    
    func showContactDetail(forContact contact: [ContactModel]) {
        
        print("whut: \(contact)")
        
        let fullName = (contact.first?.firstName)! + " " + (contact.first?.lastName)!
        name.text = fullName
        email.text = contact.first?.email
        mobile.text = contact.first?.phoneNumber
        
        let url = URL(string: (contact.first?.profilePicture)!)!
        let placeholderImage = UIImage(named: "user")!
        profilePicture?.af_setImage(withURL: url, placeholderImage: placeholderImage)
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
