//
//  Responses.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

struct Services {
    var method: String?
    var path: String
    var body: Data?
    var headers: [String:String]?
    
    init(microService: MicroservicePaths, parameters: Data? = nil, headers: [String:String]? = nil) {
        self.method = microService.method
        self.path = microService.path
        self.body = parameters
        self.headers = headers
    }
}

