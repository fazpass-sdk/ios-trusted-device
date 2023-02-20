//
//  BiometryManager.swift
//  Fazpass
//
//  Created by Akbar Putera on 20/02/23.
//

import LocalAuthentication

protocol Biometryprotocol {
    func getMessage(message: String?, error: NSError?)
}

class BiometryManager {
    
    let lAContext: LAContext
    var error: NSError?
    var delegate: Biometryprotocol?
    
    init() {
        self.lAContext = LAContext()
    }
    
    private func getBundleIdentifier() -> String {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            return bundleIdentifier
        } else {
            return ""
        }
    }
    
    func getSupportBiometry() {
        if lAContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            if #available(iOS 11.0, *) {
                switch lAContext.biometryType {
                case .faceID:
                    print("Face Id")
                    delegate?.getMessage(message: "face id", error: nil)
                case .touchID:
                    delegate?.getMessage(message: "touch id", error: nil)
                case .none:
                    let error: NSError = .init(domain: getBundleIdentifier(), code: 400, userInfo: ["NSLocalizedDescriptionKey": "Not Support" ])
                    delegate?.getMessage(message: nil, error: error)
                @unknown default:
                    let error: NSError = .init(domain: getBundleIdentifier(), code: 400, userInfo: ["NSLocalizedDescriptionKey": "Not Support" ])
                    delegate?.getMessage(message: nil, error: error)
                }
            } else {
                let error: NSError = .init(domain: getBundleIdentifier(), code: 400, userInfo: ["NSLocalizedDescriptionKey": "Version Not Support" ])
                delegate?.getMessage(message: nil, error: error)
            }
        } else {
            let error: NSError = .init(domain: getBundleIdentifier(), code: 400, userInfo: ["NSLocalizedDescriptionKey": "Not Support" ])
            delegate?.getMessage(message: nil, error: error)
        }
    }
}
