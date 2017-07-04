//
//  AddEditContactRemoteDataManager.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 7/3/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class AddEditContactRemoteDataManager: AddEditContactRemoteDataManagerInputProtocol {
    var remoteRequestHandler:
    AddEditContactRemoteDataManagerOutputProtocol?
    
//    func retrieveContactById(id: Int) {
//        print("ContactDetailRemoteDataManager")
//        
//        Alamofire.request("\(Endpoints.User.fetch.url)/\(id).json", method: .get)
//            .validate()
//            .responseObject(completionHandler: { (response: DataResponse<ContactModel>) in
//                print("response: \(response)")
//                switch response.result {
//                case .success(let contacts):
//                    print("contacts: \(contacts)")
//                    self.remoteRequestHandler?.onContactsRetrieved([contacts])
//                    
//                case .failure(let err):
//                    print("Error: \(err.localizedDescription)")
//                    self.remoteRequestHandler?.onError(errorMessage: err.localizedDescription)
//                }
//            })
//    }
//    
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        let url = URL(string: "\(Endpoints.User.fetch.url)\(id).json")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let parameters: Parameters = ["first_name": firstName,
                                      "last_name": lastName]
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            // No-op
        }
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        Alamofire.request(urlRequest)
            .validate()
            .responseObject(completionHandler: { (response: DataResponse<ContactModel>) in
                switch response.result {
                case .success(let contacts):
                    self.remoteRequestHandler?.onContactEdited([contacts])
                case .failure(let err):
                    self.remoteRequestHandler?.onError(errorMessage: err.localizedDescription)
                }
            })
    }
}
