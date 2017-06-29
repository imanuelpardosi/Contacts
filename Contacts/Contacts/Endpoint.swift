//
//  Endpoint.swift
//  Contacts
//
//  Created by Mobile Jakarta Team on 6/28/17.
//  Copyright © 2017 Tebet Utara. All rights reserved.
//

import Foundation

struct API {
    static let baseUrl = "http://gojek-contacts-app.herokuapp.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    enum Contacts: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch:
                return "/contacts.json"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch:
                return "\(API.baseUrl)\(path)"
            }
        }
    }
    
    enum User: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch:
                return "/contacts/"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch:
                return "\(API.baseUrl)\(path)"
            }
        }
    }
}
