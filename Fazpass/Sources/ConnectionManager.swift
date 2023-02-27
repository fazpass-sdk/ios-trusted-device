//
//  ConnectionManager.swift
//  Fazpass
//
//  Created by Akbar Putera on 27/02/23.
//

import Foundation

class ConnectionManager: NSObject {
    func checkNetworkConnectivity() -> Bool {
        let reachability = try! Reachability()
        if reachability.connection == .wifi {
            print("Connected to Wi-Fi")
            return true
        } else if reachability.connection == .cellular {
            print("Connected to cellular data")
            return true
        } else {
            print("No network connection")
            return false
        }
    }
}
