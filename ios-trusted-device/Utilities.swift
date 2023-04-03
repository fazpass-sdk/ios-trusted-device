//
//  Utilities.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

internal struct Utilities {
    static func debug(_ responseData: Data) {
        let printedResponse = JSON(responseData)
        print(printedResponse)
    }
}

