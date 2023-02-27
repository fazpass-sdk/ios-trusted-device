//
//  CarrierManager.swift
//  Fazpass
//
//  Created by Akbar Putera on 27/02/23.
//

import Foundation
import CoreTelephony

class CarrierManager {
    func getInfo(completion: @escaping (Dictionary<String?,Any?>?, CTCarrier?) -> Void) {
        if #available(iOS 12.0, *) {
            if let providers = CTTelephonyNetworkInfo().serviceSubscriberCellularProviders {
                completion(providers, nil)
            }
        } else {
            let provider = CTTelephonyNetworkInfo().subscriberCellularProvider
            return completion(nil, provider)
        }
    }
}
