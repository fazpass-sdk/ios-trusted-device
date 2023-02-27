//
//  FazpassTd.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 11/01/23.
//

import Foundation

public class TrustedDevice {
    private var usecase: UsecaseProtocol
    private var biometry: BiometryManager
    
    init() {
        self.usecase = Usecases.init()
        self.biometry = BiometryManager()
    }
    
    public func checkDevice(_ email: String?,_ phone: String?, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postCheck(phoneNumber: phone ?? "", email: email ?? "", completion: results)
    }
    
    public func removeDevice(results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postRemoveDevice(completion: results)
    }
    
    public func verifyDevice(results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postVerify(completion: results)
    }
    
    public func enrollDeviceByPin(_ email: String?,_ phone: String?, pin: String?, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        self.usecase.postEnroll(phone: phone, email: email, pin: pin, isBiometry: nil, completion: results)
    }
    
    public func enrollDeviceBiometry(_ email: String?,_ phone: String?, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        biometry.openBiometry { status in
            if status {
                self.usecase.postEnroll(phone: phone, email: email, pin: nil, isBiometry: status, completion: results)
            }
        }
    }
}
