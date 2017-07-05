//
//  AddEditContactView.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/2/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class AddEditContactView: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    var presenter: AddEditContactPresenterProtocol?
    var hud: HUD = HUD()
    var uiViewUtilities: UIViewUtilities = UIViewUtilities()
    var colorUtilities: ColorUtilities = ColorUtilities()
    let picker = UIImagePickerController()
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var cameraIcon: UIImageView!
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        presenter?.viewDidLoad()
        
        let backItem = UIBarButtonItem()
        backItem.title = "Cancel"
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backItem
        
        let doneItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        self.navigationItem.rightBarButtonItem = doneItem
        self.navigationController?.navigationBar.tintColor = colorUtilities.colorFromHex(hex: "#50E3C2")
        self.navigationController?.view.backgroundColor = UIColor.white
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openCamera(tapGestureRecognizer:)))
        cameraIcon.isUserInteractionEnabled = true
        cameraIcon.addGestureRecognizer(tapGestureRecognizer)
        
        uiViewUtilities.borderView(views: profilePicture, borderWidth: 3, color: UIColor.white)
        uiViewUtilities.circleView(views: profilePicture, cameraIcon)
        uiViewUtilities.setGradientBackground(topColor: "#FFFFFF", bottomColor: "#50E3C2", uiView: gradientView)
    }

    func doneTapped() {
        showLoading()
        if presenter?.method == "Edit" {
            presenter?.updateContact(id: id, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: mobile.text!, email: email.text!)
        } else {
            presenter?.addContact(id: id, firstName: firstName.text!, lastName: lastName.text!, phoneNumber: mobile.text!, email: email.text!)
        }
        
    }
    
    func openCamera(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let refreshAlert = UIAlertController(title: "", message: "Change Profile Picture", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        refreshAlert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { (action: UIAlertAction!) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.picker.allowsEditing = false
                self.picker.sourceType = UIImagePickerControllerSourceType.camera
                self.picker.cameraCaptureMode = .photo
                self.picker.modalPresentationStyle = .fullScreen
                self.present(self.picker,animated: true,completion: nil)
            } else {
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { (action: UIAlertAction!) in
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.picker.modalPresentationStyle = .popover
            self.present(self.picker, animated: true, completion: nil)
            //picker.popoverPresentationController?.barButtonItem = sender
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        profilePicture.contentMode = .scaleAspectFit //3
        profilePicture.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddEditContactView: AddEditContactViewProtocol {
    
    func showAddEditContact(forContact contact: ContactModel) {
        id = contact.id
        firstName.text = contact.firstName
        lastName.text = contact.lastName
        mobile.text = contact.phoneNumber
        email.text = contact.email
        
        let placeholderImage = UIImage(named: "user")!
        let profilePictureUrl = URL(string: (contact.profilePicture))
        profilePicture?.af_setImage(withURL: profilePictureUrl!, placeholderImage: placeholderImage)
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
