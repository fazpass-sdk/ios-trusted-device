//
//  Crypto.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 28/03/23.
//

import Foundation

import CryptoSwift

class Crypto {
    var encryptionKey:String = "A_SIXTEEN_CHARACTER_STRING";
    var encryptionIV:String = "A_SIXTEEN_CHARACTER_STRING";
    
    init(key: String, iv: String){
        self.encryptionKey = key
        self.encryptionIV = iv
    }
    
    init(){
        
    }

    public func encryptString(data: String)->String {
        let encryptedTest:String = try! data.aesEncrypt(key: encryptionKey, iv: encryptionIV)
        return encryptedTest
    }

    public func dencryptString(encripted: String)->String {
        let dencryptedTest: String = try! encripted.aesDecrypt(key:encryptionKey,iv:encryptionIV)
        return dencryptedTest
    }
    
    public func generateMeta()->String{
        let key = UUID().uuidString
        FazpassContext().privateKey = key
        let privateKey: String = String(key.prefix(16))
        let ivKey: String = String(key.suffix(16))
        let c = Crypto(key: privateKey, iv: ivKey)
        return c.encryptString(data: ivKey)
    
    }
}

extension String{
    
    func aesEncrypt(key: String, iv: String) throws -> String {
        let data = self.data(using: .utf8)!
        let encrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).encrypt([UInt8](data));
//        let encrypted = try! AES(key: key, blockMode: .CBC, padding: .pkcs7) //AES(key: key, iv: iv, blockMode: .CBC, padding: .pkcs7).encrypt([UInt8](data))
        let encryptedData = Data(encrypted)
        return encryptedData.base64EncodedString()
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = Data(base64Encoded: self)!
        let decrypted = try! AES(key: Array(key.utf8), blockMode: CBC.init(iv: Array(iv.utf8)), padding: .pkcs7).decrypt([UInt8](data));
        let decryptedData = Data(decrypted)
        return String(bytes: decryptedData.bytes, encoding: .utf8) ?? "Could not decrypt"
        
    }
}
