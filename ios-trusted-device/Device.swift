//
//  Device.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import UIKit

class Device: NSObject {
    
    func getPackageName() -> String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    func getDeviceName() -> String {
        return UIDevice.current.name
    }

    func getOsVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    func getTimeZone() -> String {
        return TimeZone.current.identifier
    }
    
    func getUUId() -> String {
        let uuidString = UUID().uuidString
        return uuidString
    }
}

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
}

