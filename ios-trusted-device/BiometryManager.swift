//
//  BiometryManager.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import LocalAuthentication

class BiometryManager {
    
    let lAContext: LAContext
    var error: NSError?
    
    init() {
        self.lAContext = LAContext()
    }
    
    func openBiometry(completion: @escaping (Bool) -> Void) {
        var error: NSError?
        guard lAContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            completion(false)
            return
        }
        
        Task {
            do {
                try await lAContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate")
                completion(true)
            } catch {
                completion(false)
            }
        }
    }
}

