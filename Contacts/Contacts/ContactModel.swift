//
//  ContactModel.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import ObjectMapper

struct ContactModel {
    var id = 0
    var firstName = ""
    var lastName = ""
    var profilePicture = ""
    var favorite = false
    var url = ""
    var email = ""
    var phoneNumber = ""
}

extension ContactModel: Mappable {
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        profilePicture <- map["profile_pic"]
        favorite <- map["favorite"]
        url <- map["url"]
        email <- map["email"]
        phoneNumber <- map["phoneNumber"]
    }
}
