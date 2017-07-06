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
    
    func addContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        let url = URL(string: Endpoints.Contacts.fetch.url)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let parameters: Parameters = ["first_name": firstName,
                                      "last_name": lastName,
                                      "phone_number": phoneNumber,
                                      "email": email,
                                      "url": ""]
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
                    self.remoteRequestHandler?.onContactAdded([contacts])
                case .failure(let err):
                    self.remoteRequestHandler?.onError(errorMessage: err.localizedDescription)
                }
            })
    }
    
    func updateContact(id: Int, firstName: String, lastName: String, phoneNumber: String, email: String) {
        let url = URL(string: "\(Endpoints.User.fetch.url)\(id).json")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        
        let parameters: Parameters = ["first_name": firstName,
                                      "last_name": lastName,
                                      "phone_number": phoneNumber,
                                      "email": email]
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
