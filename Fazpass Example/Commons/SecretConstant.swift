//
//  SecretConstant.swift
//  Fazpass Example
//
//  Created by Akbar Putera on 21/02/23.
//

import Foundation

struct SecretConstant {
    static let merchantKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZGVudGlmaWVyIjozNn0.mfny8amysdJQYlCrUlYeA-u4EG1Dw9_nwotOl-0XuQ8"
    static let gateWayHe = "b038aebb-718b-4845-bb20-3ca0d03f1b5a"
    
    enum GateWayType: String {
        case sms = "8b7dcad3-8533-49aa-9347-4591c4ea98b3"
        case wa = "b33318cf-0d10-4c90-816a-585a5dfb46ef"
        case waLong = "32f5aa02-e0a5-427d-a235-383fdcb32632"
        case miscall = "9defc750-83d8-4167-93e4-4fdab80a3eaf"
    }
}
