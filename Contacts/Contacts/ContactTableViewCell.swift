//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var favorite: UIImageView!

    func set() {
        self.selectionStyle = .none
        name.text = "Amitabh Bachchan"
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
    }
}
