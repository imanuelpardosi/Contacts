//
//  ContactDetailRemoteDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/30/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class ContactDetailRemoteDataManager: ContactDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler:
    ContactDetailRemoteDataManagerOutputProtocol?
    
    func retrieveContactById(id: Int) {
        
        Alamofire.request("Endpoints.User.fetch.url/\(id).json", method: .get)
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
