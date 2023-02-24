//
//  Permission.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 10/01/23.
//

import UIKit
import NetworkExtension

class Permission {
    
    private var context: FazpassContext
    private var locationManager: LocationManager
    private var contactManager: ContactManager
    private var biometryManager: BiometryManager
    
    init(context: FazpassContext) {
        self.context = context
        self.locationManager = LocationManager()
        self.contactManager = ContactManager()
        self.biometryManager = BiometryManager()
        self.biometryManager.delegate = self
        self.locationManager.delegate = self
        self.contactManager.delegate = self
    }
    
    func checkLocationManagerAuthorization() {
        locationManager.checkLocationManagerAuthorization()
    }
    
    func fetchContacts() {
        contactManager.fetchContacts()
    }
    
    func isJailBreak() -> Bool {
        for tool in Constant.jailbreakTools {
            if UIApplication.shared.canOpenURL(URL(string: tool)!) {
                return true
            } else {
                return false
            }
        }
        return false
    }
    
    func isSumulator() -> Bool {
        return Platform.isSimulator
    }
    
    func isVpnConnected() -> Bool {
        let vpnManager = NEVPNManager.shared()
        let connection = vpnManager.connection
        return connection.status == .connected
    }
}

extension Permission: LocationManagerProtocol {
    func getLocation(location: Location?) {
        context.location = location
    }
}

extension Permission: ContactProtocol {
    func getNumberOfContact(contact: Int?) {
        context.numberOfContact = contact
    }
}

extension Permission: Biometryprotocol {
    func getMessage(message: String?, error: NSError?) {
        print("\(message ?? "") \(error?.localizedDescription ?? "")")
    }
}
