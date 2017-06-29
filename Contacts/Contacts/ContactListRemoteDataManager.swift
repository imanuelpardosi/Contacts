//
//  ContactListRemoteDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ContactListRemoteDataManager: ContactListRemoteDataManagerInputProtocol {
    var remoteRequestHandler:
    ContactListRemoteDataManagerOutputProtocol?
    
    func retreaveContactList() {
        Alamofire.request(Endpoints.Contacts.fetch.url, method: .get)
            .validate()
            .responseArray(completionHandler: { (response: DataResponse<[ContactModel]>) in
                switch response.result {
                case .success(let contacts):
                    print("contacts: \(contacts)")
                    self.remoteRequestHandler?.onContactsRetrieved(contacts)
                    
                case .failure( _):
                    self.remoteRequestHandler?.onError()
                }
            })
    }
}
