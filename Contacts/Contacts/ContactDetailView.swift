//
//  ContactDetailView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/29/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit
import MessageUI


class ContactDetailView: UIViewController, MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var btnMessage: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var btnEmail: UIButton!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var mobile: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var btnHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradientView: UIView!
    
    var getContact: ContactModel = ContactModel()
    var hud: HUD = HUD()
    var uiViewUtilities: UIViewUtilities = UIViewUtilities()
    var colorUtilities: ColorUtilities = ColorUtilities()
    var presenter: ContactDetailPresenterProtocol?
    
    @IBAction func btnCancelOnClick(_ sender: Any) {
        print("cancel")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnHeightConstraint.constant = btnMessage.frame.width
        
        print("btnHeightConstraint.constant: \(btnHeightConstraint.constant)")
        print("btnMessage.frame.width: \(btnMessage.frame.width)")
        
        presenter?.viewDidLoad()
        let backItem = UIBarButtonItem(title: "Contact", style: .plain, target: self, action: #selector(backTapped))
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backItem
        
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        self.navigationItem.rightBarButtonItem = edit
        self.navigationController?.navigationBar.tintColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        uiViewUtilities.circleView(views: profilePicture, btnMessage, btnCall, btnEmail, btnFavorite)
        uiViewUtilities.setGradientBackground(topColor: "#FFFFFF", bottomColor: "#50E3C2", uiView: gradientView)
        
    }
    
    func backTapped() {
        presenter?.showContactList()
    }
    
    func editTapped(sender: UIBarButtonItem) {
        presenter?.showEditContact(forContact: getContact)
    }

    @IBAction func btnMessageOnClick(_ sender: Any) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "Enter a message";
        messageVC.recipients = [mobile.text!]
        messageVC.messageComposeDelegate = self
        
        self.present(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func btnCallOnClick(_ sender: Any) {
        guard let number = URL(string: "tel://" + mobile.text!) else { return }
        UIApplication.shared.open(number)
    }
    
    @IBAction func btnEmailOnClick(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([email.text!])
            mail.setSubject("Hello there!")
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    @IBAction func btnFavoriteOnClick(_ sender: Any) {
        presenter?.updateFavorite(id: getContact.id)
        
        let favorite = presenter?.getCurrentFavorite(id: getContact.id)
        if favorite! {
            btnFavorite.backgroundColor = UIColor.brown
        } else {
            btnFavorite.backgroundColor = colorUtilities.colorFromHex(hex: "#50E3C2")
            
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(controller: MFMailComposeViewController,
                               didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ContactDetailView: ContactDetailViewProtocol {
    
    func showContactDetail(forContact contact: [ContactModel]) {
        getContact = contact.first!
        
        let fullName = (contact.first?.firstName)! + " " + (contact.first?.lastName)!
        name.text = fullName
        email.text = contact.first?.email
        mobile.text = contact.first?.phoneNumber
        
        let placeholderImage = UIImage(named: "user")!
        let profilePictureUrl = URL(string: (contact.first?.profilePicture)!)
        profilePicture?.af_setImage(withURL: profilePictureUrl!, placeholderImage: placeholderImage)
        
        if getContact.favorite {
            btnFavorite.backgroundColor = UIColor.brown
        } else {
            btnFavorite.backgroundColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        }
        uiViewUtilities.borderView(views: profilePicture, borderWidth: 3, color: UIColor.white)
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
