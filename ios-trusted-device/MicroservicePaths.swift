//
//  MicroservicePaths.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

enum MicroservicePaths {
    case postCheck
    case postEnroll
    case postVerification
    case postRemove
    case postNotification
    case postConfirmStatus
    case postValidatePin
    case postOtpSend
    case postOtpGenerate
    case postOtpRequest
    case postWABlasting
    case postSMSlasting
    case postCallbackMotp
    case putLastUpdateDevice
    case putUpdateExpired
    case putUpdateNotificationToken
    case getAuthPage
    case postTdVerify
}

extension MicroservicePaths {
    var method: String {
        switch self {
        case .putLastUpdateDevice, .putUpdateExpired, .putUpdateNotificationToken:
            return "PUT"
        default:
            return "POST"
        }
    }
    var path: String {
        switch self {
        case .postVerification:
            return Constant.version + "otp/verify"
        case .postOtpSend:
            return Constant.version + "otp/send"
        case .postOtpGenerate:
            return Constant.version + "otp/generate"
        case .postOtpRequest:
            return Constant.version + "otp/request"
        case .postWABlasting:
            return Constant.version + "message/send"
        case .postSMSlasting:
            return Constant.version + "callback/citcall/motp"
        case .postCallbackMotp:
            return Constant.version + "callback/citcall/smsotp"
        case .getAuthPage:
            return Constant.version + "he/request/auth-page"
        case .postCheck:
            return Constant.version + Constant.applicationContext + "check"
        case .postEnroll:
            return Constant.version + Constant.applicationContext + "enroll"
        case .putLastUpdateDevice:
            return Constant.version + Constant.applicationContext + "update/last-active"
        case .putUpdateExpired:
            return Constant.version + Constant.applicationContext + "update/expired"
        case .putUpdateNotificationToken:
            return Constant.version + Constant.applicationContext + "update/notification-token"
        case .postRemove:
            return Constant.version + Constant.applicationContext + "remove"
        case .postNotification:
            return Constant.version + Constant.applicationContext + "send/notification"
        case .postConfirmStatus:
            return Constant.version + Constant.applicationContext + "confirmation/status"
        case .postValidatePin:
            return Constant.version + Constant.applicationContext + "validate/pin"
        case .postTdVerify:
            return Constant.version + Constant.applicationContext + "verify"
        }
    }
}
