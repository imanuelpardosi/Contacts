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
        print("ContactDetailRemoteDataManager")
        
        print("URL: \(Endpoints.User.fetch.url)")
        print("id: \(id).json")
        Alamofire.request("\(Endpoints.User.fetch.url)/\(id).json", method: .get)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ContactModel>) in
                print("response: \(response)")
                switch response.result {
                case .success(let contacts):
                    print("contacts: \(contacts)")
                    self.remoteRequestHandler?.onContactsRetrieved([contacts])
                    
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                    self.remoteRequestHandler?.onError(errorMessage: err.localizedDescription)
                }
            })
    }


            //.responseArray(completionHandler: { (response: DataResponse<[ContactModel]>) in
//                
//                print("response: \(response)")
//                switch response.result {
//                case .success(let contacts):
//                    print("contacts: \(contacts)")
//                    self.remoteRequestHandler?.onContactsRetrieved(contacts)
//                    
//                case .failure(let err):
//                    print("Error: \(err.localizedDescription)")
//                    self.remoteRequestHandler?.onError()
//                }
//            })
        
//        .responseString { response in
//            print("Success: \(response.result.isSuccess)")
//            print("Response String: \(response.result.value)")
//        }
        
    
}
