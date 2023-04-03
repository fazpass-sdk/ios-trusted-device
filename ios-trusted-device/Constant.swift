//
//  Constant.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation
struct Constant {
    static let developmentUrl = "https://channa.fazpas.com"
    static let productionUrl = "https://api.fazpas.com"
    static let version = "/v1/"
    static let applicationContext = "trusted-device/"
    
    static let jailbreakTools = [
        "cydia://",
        "sileo://",
        "electra://",
        "unc0ver://"
    ]
}

public enum Status {
    case trusted
    case untrusted
    
    static func setStatus(status: Bool?) -> Status {
        return status == true ? .trusted : .untrusted
    }
}

public enum TD_MODE : String {
    case DEV = "DEVELOPMENT"
    case STAGING = "STAGING"
    case PROD = "PRODUCTION"
    
    var baseUrlAs: String {
        switch self {
        case .DEV: return Constant.developmentUrl
        case .STAGING: return Constant.developmentUrl
        case .PROD: return Constant.developmentUrl
        }
    }
}
