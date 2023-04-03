//
//  User.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

public struct User: Codable {
    var pin, app, device, userId: String?
    public init(pin: String? = nil, app: String? = nil, device: String? = nil, userId: String? = nil) {
        self.pin = pin
        self.app = app
        self.device = device
        self.userId = userId
    }
}

