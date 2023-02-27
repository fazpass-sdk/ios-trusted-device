//
//  Usecases.swift
//  ios-trusted-device
//
//  Created by Binar - Mei on 06/01/23.
//

import Foundation

typealias returnVoid = (Result<Void, FazPassError>) -> Void
public typealias returnGeneralResponse = (Result<DataResponse?, FazPassError>) -> Void
typealias returnApiResponse = (Results<DataResponse?, String, FazPassError>) -> Void
typealias returnOtpResponse = (Results<OtpResponse?, String?, FazPassError>) -> Void
typealias returnSendOtpResponse = (Result<OtpResponse?, FazPassError>) -> Void

protocol UsecaseProtocol {
    func postCheck(phoneNumber: String, email: String, completion: @escaping returnGeneralResponse)
    func postEnroll(phone: String?, email: String?, pin: String?, isBiometry: Bool?, completion: @escaping returnGeneralResponse)
    func postValidatePin(pin: String, completion: @escaping returnGeneralResponse)
    func postRemoveDevice(completion: @escaping returnGeneralResponse)
    func postOtpGenerate(phoneNumber: String, gateWay: String, completion: @escaping returnOtpResponse)
    func postOtpGenerate(email: String, gateWay: String, completion: @escaping returnOtpResponse)
    func postOtpRequest(phoneNumber: String, gateWay: String, completion: @escaping returnOtpResponse)
    func postOtpRequest(email: String, gateWay: String, completion: @escaping returnOtpResponse)
    func postOtpSend(otp: String, email: String, gateWay: String, completion: @escaping returnSendOtpResponse)
    func postOtpSend(otp: String, phoneNumber: String, gateWay: String, completion: @escaping returnSendOtpResponse)
    func postAuthPage(phoneNumber: String, gateWay: String, completion: @escaping returnGeneralResponse)
    func postVerificationOtp(otp: String, otpId: String, completion: @escaping (Result<Bool, FazPassError>) -> Void)
    func postVerify(completion: @escaping returnGeneralResponse)
    func putUpdateLastActive(completion: @escaping returnGeneralResponse)
    func postSendNotification(completion: @escaping returnGeneralResponse)
    func postConfirmationStatus(completion: @escaping returnGeneralResponse)
    func putUpdateExpire(completion: @escaping returnGeneralResponse)
    func putUpdateNotificationToken(completion: @escaping returnGeneralResponse)
    func getNumber() -> String?
    func setNumber(number: String?)
}

class Usecases: UsecaseProtocol {

    private var device: Device
    private var context: FazpassContext
    private var permission: Permission
    
    init() {
        self.device = .init()
        self.context = FazpassContext.shared
        self.permission = Permission(context: context)
        permission.checkLocationManagerAuthorization()
    }
    
    func postOtpRequest(phoneNumber: String, gateWay: String, completion: @escaping returnOtpResponse) {
        let parameter = Parameters(["phone" : phoneNumber, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpRequest, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
                completion(.incomingMessage(response.data?.otp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postOtpRequest(email: String, gateWay: String, completion: @escaping returnOtpResponse) {
        let parameter = Parameters(["email" : email, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpRequest, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
                completion(.incomingMessage(response.data?.otp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postOtpGenerate(phoneNumber: String, gateWay: String, completion: @escaping returnOtpResponse) {
        let parameter = Parameters(["phone" : phoneNumber, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpGenerate, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
                completion(.incomingMessage(response.data?.otp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func postOtpGenerate(email: String, gateWay: String, completion: @escaping returnOtpResponse) {
        let parameter = Parameters(["email" : email, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpGenerate, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
                completion(.incomingMessage(response.data?.otp))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    func postOtpSend(otp: String, email: String, gateWay: String, completion: @escaping returnSendOtpResponse) {
        let parameter = Parameters(["otp" : otp, "email" : email, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpSend, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postOtpSend(otp: String, phoneNumber: String, gateWay: String, completion: @escaping returnSendOtpResponse) {
        let parameter = Parameters(["otp" : otp, "phone" : phoneNumber, "gateway_key" : gateWay])
        let service = Services.init(microService: .postOtpSend, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<OtpResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postAuthPage(phoneNumber: String, gateWay: String, completion: @escaping returnGeneralResponse) {
        let parameter = Parameters(["phone_number" : phoneNumber, "gateway_key" : gateWay])
        let service = Services.init(microService: .getAuthPage, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postVerificationOtp(otp: String, otpId: String, completion: @escaping (Result<Bool, FazPassError>) -> Void) {
        let parameter = Parameters(["otp" : otp, "otp_id" : otpId])
        let service = Services.init(microService: .postVerification, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { result in
            switch result {
            case .success:
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: trusted device
    func postValidatePin(pin: String, completion: @escaping returnGeneralResponse) {
        var request = TrustedDeviceRequest()
        request.userId = context.userId
        request.app = device.getPackageName()
        request.device = device.getDeviceName()
        request.pin = pin
        
        let parameter = Parameters(request)
        let service = Services.init(microService: .postValidatePin, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postRemoveDevice(completion: @escaping returnGeneralResponse) {
        var request = TrustedDeviceRequest()
        request.userId = context.userId
        request.device = device.getDeviceName()
        request.app = device.getPackageName()
        request.location = Location.init(lat: context.location?.lat, lng: context.location?.lng)
        request.timeZone = device.getTimeZone()
        
        let parameter = Parameters(request)
        
        let service = Services.init(microService: .postRemove, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { result in
            switch result {
            case .success(let response):
                if response.status == false {
                    let error = ErrorResponse(code: response.code ?? "", status: false, message: response.message ?? "")
                    completion(.failure(.softError(error: error)))
                    return
                }
                self.context.removerUserId()
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postCheck(phoneNumber: String, email: String, completion: @escaping returnGeneralResponse) {
        var request = TrustedDeviceRequest()
        request.phone = phoneNumber
        request.email = email
        request.app = device.getPackageName()
        request.device = device.getDeviceName()
        request.location = Location.init(lat: context.location?.lat, lng: context.location?.lng)
        
        let parameter = Parameters(request)
        
        let service = Services.init(microService: .postCheck, parameters: parameter.value, headers: nil)
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let checkResponse):
                self.context.userId = checkResponse.data?.user?.id
                self.context.checkResponse = checkResponse.data
                completion(.success(checkResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postEnroll(phone: String?, email: String?, pin: String?, isBiometry: Bool?, completion: @escaping returnGeneralResponse) {
        let devicesCurrent = context.checkResponse?.apps?.current
        var request = TrustedDeviceRequest()
        request.address = ""
        request.contactCount = context.numberOfContact
        request.device = device.getDeviceName()
        request.app = device.getPackageName()
        request.email = email
        request.phone = phone
        request.pin = pin
        request.ktp = ""
        request.key = context.checkResponse?.apps?.current?.key
        request.location = Location.init(lat: context.location?.lat, lng: context.location?.lng)
        request.meta = context.checkResponse?.apps?.current?.meta
        request.name = ""
        request.notificationToken = ""
        request.sim = [Sim.init(phone: "", serial: ""), Sim.init(phone: "", serial: "")]
        request.timeZone = device.getTimeZone()
        request.isTrusted = devicesCurrent?.isTrusted
        request.useFingerprint = isBiometry
        request.usePin = isBiometry ?? false
        request.isVPN = permission.isVpnConnected()
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .postEnroll, parameters: parameter.value)
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postVerify(completion: @escaping returnGeneralResponse) {
        var request = TrustedDeviceRequest()
        request.userId = context.userId
        request.device = device.getDeviceName()
        request.app = device.getPackageName()
        request.sim = [Sim.init(phone: "", serial: ""), Sim.init(phone: "", serial: "")]
        request.meta = context.checkResponse?.apps?.current?.meta
        request.key = context.checkResponse?.apps?.current?.key
        request.contactCount = context.numberOfContact
        request.timeZone = device.getTimeZone()
        request.location = Location.init(lat: context.location?.lat, lng: context.location?.lng)
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .postTdVerify, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putUpdateLastActive(completion: @escaping returnGeneralResponse) {
        var request = TrustedDeviceRequest()
        request.userId = context.userId
        request.app = device.getPackageName()
        request.device = device.getDeviceName()
        request.sim = [Sim.init(phone: "", serial: ""), Sim.init(phone: "", serial: "")]
        request.timeZone = device.getTimeZone()
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .putLastUpdateDevice, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postSendNotification(completion: @escaping returnGeneralResponse) {
        var request = NotificationRequest()
        request.userId = context.userId
        request.notificationToken = ""
        request.countExpired = 0
        request.otherDevice = []
        request.uuidNotif = ""
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .postNotification, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func postConfirmationStatus(completion: @escaping returnGeneralResponse) {
        var request = NotificationRequest()
        request.userId = context.userId
        request.notificationToken = ""
        request.app = device.getPackageName()
        request.device = device.getDeviceName()
        request.isConfirmation = ""
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .postConfirmStatus, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putUpdateExpire(completion: @escaping returnGeneralResponse) {
        var request = NotificationRequest()
        request.userId = context.userId
        request.uuidNotif = ""
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .putUpdateExpired, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func putUpdateNotificationToken(completion: @escaping returnGeneralResponse) {
        var request = NotificationRequest()
        request.userId = context.userId
        request.notificationToken = ""
        request.app = device.getPackageName()
        request.device = device.getDeviceName()
        request.key = ""
        
        let parameter = Parameters(request)
        
        let service = Services(microService: .putUpdateNotificationToken, parameters: parameter.value)
        
        NetworkService.instance.requestObjects(c: ApiResponse<DataResponse>.self, service: service) { response in
            switch response {
            case .success(let apiResponse):
                completion(.success(apiResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func setNumber(number: String?){
        context.carrierNumber = number
    }
    
    func getNumber() -> String? {
        return context.carrierNumber
    }
}
