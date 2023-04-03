//
//  Requests.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 27/03/23.
//

import Foundation

// MARK: - Enroll
struct TrustedDeviceRequest: Codable {
    var userId: String?
    var address: String?
    var contactCount: Int?
    var device, email, ktp, key: String?
    var location: Location?
    var meta, name, notificationToken, app: String?
    var phone, pin: String?
    var sim: [Sim]?
    var timeZone: String?
    var isTrusted, useFingerprint, usePin, isVPN: Bool?

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case address
        case contactCount = "contact_count"
        case device, email, ktp, key, location, meta, name
        case notificationToken = "notification_token"
        case app, phone, pin, sim
        case timeZone = "time_zone"
        case isTrusted = "is_trusted"
        case useFingerprint = "use_fingerprint"
        case usePin = "use_pin"
        case isVPN = "is_vpn"
    }
}

// MARK: - Sim
struct Sim: Codable {
    var phone, serial: String?
}

// MARK: - Location
public struct Location: Codable {
    var lat, lng: String?
}

// MARK: - NotificationRequest
struct NotificationRequest: Codable {
    var otherDevice: [OtherDevice]?
    var uuidNotif, notificationToken: String?
    var countExpired: Int?
    var userId, device, app: String?
    var isConfirmation, key: String?

    enum CodingKeys: String, CodingKey {
        case otherDevice = "other_device"
        case uuidNotif = "uuid_notif"
        case notificationToken = "notification_token"
        case countExpired = "count_expired"
        case userId = "user_id"
        case isConfirmation = "is_confirmation"
        case device, app, key
    }
}

// MARK: - OtherDevice
struct OtherDevice: Codable {
    var app, device: String?
}

