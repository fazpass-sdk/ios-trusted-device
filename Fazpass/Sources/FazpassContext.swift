//
//  FazzpazzContext.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 02/01/23.
//

import Foundation

class FazpassContext {
    
    private let userDefault = UserDefaults.standard
    private let merchantKeyString = "MERCHANTKEY"
    private let carrierNumberString = "CARRIERNUMBER"
    private let userIdString = "USER_ID"
    private let trustedDeviceUrl = "TRUSTED_DEVICE_URL"
    static let shared = FazpassContext()
    
    var numberOfContact: Int?
    var checkResponse: DataResponse?
    var location: Location?
    
    var merchantKey: String? {
        get {
            return userDefault.string(forKey: merchantKeyString)
        } set {
            userDefault.set(newValue, forKey: merchantKeyString)
        }
    }
    
    var buildMode: String? {
        get {
            return userDefault.string(forKey: trustedDeviceUrl)
        } set {
            userDefault.set(newValue, forKey: trustedDeviceUrl)
        }
    }
    
    var carrierNumber: String? {
        get {
            return userDefault.string(forKey: carrierNumberString)
        } set {
            userDefault.set(newValue, forKey: carrierNumberString)
        }
    }
    
    var userId: String? {
        get {
            return userDefault.string(forKey: userIdString)
        } set {
            userDefault.set(newValue, forKey: userIdString)
        }
    }
    
    func removerMerchantKey() {
        userDefault.removeObject(forKey: merchantKeyString)
    }
    
    func removerUserId() {
        userDefault.removeObject(forKey: userIdString)
    }
    
}
