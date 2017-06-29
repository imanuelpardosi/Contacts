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
    
    var presenter: ContactDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        btnHeightConstraint.constant = btnMessage.frame.width
        circleView(views: profilePicture, btnMessage, btnCall, btnEmail, btnFavorite)
    }
    
    func circleView(views: UIView...) {
        for view: UIView in views {
            view.layer.cornerRadius = view.frame.size.width / 2
            view.clipsToBounds = true
        }
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
    
    func showContactDetail(forContact contact: ContactModel) {
        name.text = "\(contact.firstName) \(contact.lastName)"
        
        let url = URL(string: contact.profilePicture)!
        let placeholderImage = UIImage(named: "user")!
        profilePicture?.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
    
}
