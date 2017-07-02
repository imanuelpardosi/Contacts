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
    var uiView: UIView = UIView()
    var presenter: ContactDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title = "Contact"
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItem = edit
        self.navigationController?.navigationBar.tintColor = colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        btnHeightConstraint.constant = btnMessage.frame.width
        circleView(views: profilePicture, btnMessage, btnCall, btnEmail, btnFavorite)
    }
    
    func editTapped(sender: UIBarButtonItem) {
        print("Edit")
    }
    
    func circleView(views: UIView...) {
        for view: UIView in views {
            view.layer.cornerRadius = view.frame.size.width / 2
            view.clipsToBounds = true
        }
    }
    
    func colorFromHex (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.characters.count) != 6) {
            print("Color haven't pager character")
            return UIColor.gray
        }
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
