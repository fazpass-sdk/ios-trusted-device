//
//  TrustedDevice.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
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
    
    public func verifyDevice(results: @escaping (Result<VerifyResponse?, FazPassError>) -> Void) {
        usecase.postVerify(completion: results)
    }
    
    public func enrollDeviceByPin(_ email: String?,_ phone: String?, pin: String?, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        self.usecase.postEnroll(phone: phone, email: email, pin: pin, isBiometry: nil, completion: results)
    }
    
    public func enrollDeviceBiometry(_ email: String?,_ phone: String?,_ pin: String, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        biometry.openBiometry { status in
            if status {
                self.usecase.postEnroll(phone: phone, email: email, pin: pin, isBiometry: status, completion: results)
            }
        }
    }
    
    public func sendNotif(countExpired: Int, notificationToken: String, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postSendNotification(countExpired: countExpired, notificationToken: notificationToken, completion: results)
    }
    
    public func notifConfirmation(notificationToken: String, isConfirmation: String, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postConfirmationStatus(notificationToken: notificationToken, isConfirmation: isConfirmation, completion: results)
    }
    
    public func updateExpire(results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.putUpdateExpire(completion: results)
    }
    
    public func updateNotification(notificationToken: String, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.putUpdateNotificationToken(notificationToken: notificationToken, completion: results)
    }
    
    public func validatePin(_ pin: String, result: @escaping (Result<BasicResponse?, FazPassError>)->Void){
        usecase.postValidatePin(pin: pin, completion: result)
    }
    
}

