//
//  Fazpass.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation
import CryptoSwift

public class Fazpass {
    
    private var usecase: UsecaseProtocol
    public static let trusted = TrustedDevice()
    public static let shared = Fazpass()
    static var meta = "";
    static var isUseFinger = false;
    public init() {
        self.usecase = Usecases()
    }
    
    public func initialize(_ MERCHANT_KEY: String,_ TD_MODE: TD_MODE) {
        if MERCHANT_KEY.isEmpty { print("merchant id cannot be null or empty") }
        FazpassContext.shared.buildMode = TD_MODE.rawValue
        guard let _ = FazpassContext.shared.merchantKey else {
            FazpassContext.shared.merchantKey = MERCHANT_KEY
            return
        }
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
        permission.fetchContacts()
        permission.checkLocationManagerAuthorization()
    }
    
    public func check(_ email:String, _ phone: String, _ status: @escaping(TD_STATUS, CD_STATUS)->()){
        TrustedDevice().checkDevice(email, phone) { res in
            do{
                let data = try res.get()
                if(data?.user==nil && data?.apps==nil){
                    status(TD_STATUS.UNTRUSTED, CD_STATUS.UNAVAILABLE)
                }else{
                    Fazpass.isUseFinger = ((data?.apps?.current?.useFingerprint) != nil)
                    Fazpass.meta = data?.apps?.current?.meta ?? ""
                    if(data?.apps?.others?.count ?? 0 >= 1 && data?.apps?.crossApp==true){
                        status(TD_STATUS.TRUSTED, CD_STATUS.AVAILABLE)
                    }else if(data?.apps?.others?.count ?? 0 < 1 && data?.apps?.crossApp==true){
                        status(TD_STATUS.TRUSTED, CD_STATUS.UNAVAILABLE)
                    }else if(data?.apps?.others?.count ?? 0 >= 1 && data?.apps?.crossApp==false){
                        if(self.checkMeta(meta: data?.apps?.current?.meta ?? "")){
                            status(TD_STATUS.TRUSTED, CD_STATUS.AVAILABLE)
                        }else{
                            status(TD_STATUS.UNTRUSTED, CD_STATUS.AVAILABLE)
                        }
                    }else{
                        if(self.checkMeta(meta: data?.apps?.current?.meta ?? "")){
                            status(TD_STATUS.TRUSTED, CD_STATUS.UNAVAILABLE)
                        }else{
                            status(TD_STATUS.UNTRUSTED, CD_STATUS.UNAVAILABLE)
                        }
                    }
                }
            }catch{
                status(TD_STATUS.UNTRUSTED, CD_STATUS.UNAVAILABLE)
            }
            
            /*
            res.map({ data in
                if(data?.user==nil && data?.apps==nil){
                    status(TD_STATUS.UNTRUSTED, CD_STATUS.UNAVAILABLE)
                }else{
                    Fazpass.isUseFinger = ((data?.apps?.current?.useFingerprint) != nil)
                    Fazpass.meta = data?.apps?.current?.meta ?? ""
                    if(data?.apps?.others?.count ?? 0 >= 1 && data?.apps?.crossApp==true){
                        status(TD_STATUS.TRUSTED, CD_STATUS.AVAILABLE)
                    }else if(data?.apps?.others?.count ?? 0 < 1 && data?.apps?.crossApp==true){
                        status(TD_STATUS.TRUSTED, CD_STATUS.UNAVAILABLE)
                    }else if(data?.apps?.others?.count ?? 0 >= 1 && data?.apps?.crossApp==false){
                        if(self.checkMeta(meta: data?.apps?.current?.meta ?? "")){
                            status(TD_STATUS.TRUSTED, CD_STATUS.AVAILABLE)
                        }else{
                            status(TD_STATUS.UNTRUSTED, CD_STATUS.AVAILABLE)
                        }
                    }else{
                        if(self.checkMeta(meta: data?.apps?.current?.meta ?? "")){
                            status(TD_STATUS.TRUSTED, CD_STATUS.UNAVAILABLE)
                        }else{
                            status(TD_STATUS.UNTRUSTED, CD_STATUS.UNAVAILABLE)
                        }
                    }
                }
                
            })
            */
        }
    }
    
    public func enrollDeviceByPin(_ email: String, _ phone: String, _ pin: String, _ status: @escaping (Bool, String)->()){
        if(Fazpass.meta==""){
            TrustedDevice().enrollDeviceByPin(email, phone, pin: pin) { result in
                status(true, "Enroll success")
            }
        }else{
            TrustedDevice().validatePin(pin) { validateResult in
                do{
                    let response = try validateResult.get()
                    if((response?.status) != nil){
                        TrustedDevice().removeDevice() { _ in
                            TrustedDevice().enrollDeviceByPin(email, phone, pin: pin) { _ in
                                // Nothing
                            }
                        }
                        status(true, "Enroll success")
                    }else{
                        status(false, "PIN not match")
                    }
                }catch{
                    
                }
            }
        }
    }
    
    public func enrollDeviceByFinger(email: String, phone: String, pin: String, _ status: @escaping(Bool, String)->Void){
        if(Fazpass.meta==""){
            TrustedDevice().enrollDeviceBiometry(email, phone, pin) { resukt in
                status(true, "Enroll Success")
            }
        }else{
            TrustedDevice().validatePin(pin) { validateResult in
                do{
                    let response = try validateResult.get()
                    if((response?.status) != nil){
                        TrustedDevice().removeDevice() { _ in
                            TrustedDevice().enrollDeviceBiometry(email, phone, pin) { _ in
                                // Nothing
                            }
                        }
                        status(true, "Enroll success")
                    }else{
                        status(false, "PIN not match")
                    }
                }catch{
                    
                }
            }
        }
    }

    
    public func validateDevice(pin: String, result:@escaping(Double, Bool, String)->()){
        TrustedDevice().validatePin(pin) { resp in
            /*
            resp.map { t in
                print("Validating pin .....")
                if((t?.status) != nil){
                    TrustedDevice().verifyDevice { r in
                        r.map { response in
                            var meta: Double = response?.meta ?? 0
                            var sim: Double = response?.sim ?? 0
                            var location: Double = response?.location ?? 0
                            var contact: Double = response?.contact ?? 0
                            var key: Double = response?.key ?? 0
                            var resume = meta + sim + location + contact + key
                            result(resume, true, "Validation device success")
                        }
                    }
                }else{
                    result(0, false, "Wrong PIN")
                }
            }
            */
            do{
                let t = try resp.get()
                if((t?.status) != nil){
                    TrustedDevice().verifyDevice { r in
                        do{
                            let response = try r.get()
                            let meta: Double = response?.meta ?? 0
                            let sim: Double = response?.sim ?? 0
                            let location: Double = response?.location ?? 0
                            let contact: Double = response?.contact ?? 0
                            let key: Double = response?.key ?? 0
                            let resume = meta + sim + location + contact + key
                                result(resume, true, "Validation device success")
                            
                        }catch{
                            result(0, true, "Something went wrong")
                        }
                    }
                }else{
                    result(0, false, "Wrong PIN")
                }
                
            }catch{
                result(0, false, "Something went wrong")
            }
        }
        
    }
    
    public func removeDevice(pin:String, result:@escaping(Bool,String)->()){
        TrustedDevice().validatePin(pin) { resp in
            do{
                let t = try resp.get()
                if((t?.status) != nil){
                    result(true, "Device removed")
                    TrustedDevice().removeDevice { _ in
                        // Nothing
                    }
                }else{
                    result(false, "Wrong PIN")
                }
            }catch{
                result(false, "Something went wrong")
            }
        }
    }
    
    private func checkMeta(meta:String)->Bool{
        let key = FazpassContext().privateKey ?? ""
        if(key==""){
            return false
        }else if (meta == ""){
            return false
        }else{
            let privateKey: String = String(key.prefix(16))
            let ivKey: String = String(key.suffix(16))
            let c = Crypto(key: privateKey, iv: ivKey)
            let data = c.dencryptString(encripted: meta)
            return(data==ivKey)
        }
    }
    
    public func getNumber() -> String? {
        return usecase.getNumber()
    }
    
    public func setNumber(number: String?) {
        usecase.setNumber(number: number)
    }
    
}

