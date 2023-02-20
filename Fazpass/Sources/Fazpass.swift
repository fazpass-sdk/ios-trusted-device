//
//  Fazpass.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 23/12/22.
//

import Foundation

public class Fazpass {
    
    private var usecase: UsecaseProtocol
    
    public static let trusted = TrustedDevice()
    public static let shared = Fazpass()
    
    init() {
        self.usecase = Usecases()
    }
    
    public func initialize(_ MERCHANT_KEY: String,_ TD_MODE: TD_MODE) {
        if MERCHANT_KEY.isEmpty { print("merchant id cannot be null or empty") }
        guard let _ = FazpassContext.shared.merchantKey else {
            FazpassContext.shared.merchantKey = MERCHANT_KEY
            return
        }
    }
    
    public func removeDevice(pin: String, results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        Usecases.init().postRemoveDevice(pin: pin, completion: results)
    }
    
    public func requestOtpByPhone(_ phoneNumber: String,_ gateWay: String,_ results: @escaping (Results<OtpResponse?, String?, FazPassError>) -> Void) {
        usecase.postOtpRequest(phoneNumber: phoneNumber, gateWay: gateWay, completion: results)
    }
    
    public func requestOtpByEmail(_ email: String,_ gateWay: String,_ results: @escaping (Results<OtpResponse?, String?, FazPassError>) -> Void) {
        usecase.postOtpRequest(email: email, gateWay: gateWay, completion: results)
    }
    
    public func generateOtpByPhone(_ phoneNumber: String,_ gateWay: String,_ results: @escaping (Results<OtpResponse?, String?, FazPassError>) -> Void) {
        usecase.postOtpGenerate(phoneNumber: phoneNumber, gateWay: gateWay, completion: results)
    }
    
    public func generateOtpByEmail(_ email: String,_ gateWay: String,_ results: @escaping (Results<OtpResponse?, String?, FazPassError>) -> Void) {
        usecase.postOtpGenerate(email: email, gateWay: gateWay, completion: results)
    }
    
    public func sendOtpByPhone(_ otp: String, _ phoneNumber: String,_ gateWay: String,_ results: @escaping (Result<OtpResponse?, FazPassError>) -> Void) {
        usecase.postOtpSend(otp: otp, phoneNumber: phoneNumber, gateWay: gateWay, completion: results)
    }
    
    public func sendOtpByEmail(_ otp: String, _ email: String,_ gateWay: String,_ results: @escaping (Result<OtpResponse?, FazPassError>) -> Void) {
        usecase.postOtpSend(otp: otp, email: email, gateWay: gateWay, completion: results)
    }
    
    public func verificationOtp(_ otp: String,_ otpId: String,_ results: @escaping (Result<Bool, FazPassError>) -> Void) {
        usecase.postVerificationOtp(otp: otp, otpId: otpId, completion: results)
    }
    
    public func headerEnreachment(_ phoneNumber: String,_ gateWay: String,_ results: @escaping (Result<DataResponse?, FazPassError>) -> Void) {
        usecase.postAuthPage(phoneNumber: phoneNumber, gateWay: gateWay, completion: results)
    }
    
    public func permissionCheck() {
        let context = FazpassContext.shared
        let permission = Permission.init(context: context)
        permission.checkLocationManagerAuthorization()
    }
    
    public func getNumber() -> String? {
        return usecase.getNumber()
    }
    
    public func setNumber(number: String?) {
        usecase.setNumber(number: number)
    }
    
}
