//
//  FazpazzConstant.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 30/12/22.
//

import Foundation

struct Constant {
    static let developmentUrl = "https://channa.fazpas.com"
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
        case .STAGING: return "STAGING"
        case .PROD: return "PROD"
        }
    }
}
