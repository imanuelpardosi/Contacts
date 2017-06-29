//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UIImageView!

    func set(forContact contact: ContactModel) {
        self.selectionStyle = .none
        name.text = "\(contact.firstName) \(contact.lastName)"
        if !contact.favorite {
            favorite.isHidden = true
        } else {
            favorite.isHidden = false
        }
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        
        let url = URL(string: contact.profilePicture)!
        let placeholderImage = UIImage(named: "user")!
        profilePicture?.af_setImage(withURL: url, placeholderImage: placeholderImage)
    }
}
