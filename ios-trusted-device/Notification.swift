//
//  Notification.swift
//  ios-trusted-device
//
//  Created by Andri nova riswanto on 28/03/23.
//

import Foundation
import FirebaseCore
import Firebase
import FirebaseMessaging

public class FazpassNotification{
    public init(){
//        var fcmUserId = FazpassContext().fcmUserId ?? ""
//        if(fcmUserId==""){
//            fcmUserId = UUID().uuidString
//        }
//        let pushManager = PushNotificationManager(userID: fcmUserId)
//            pushManager.registerForPushNotifications()
//            FirebaseApp.configure()
    }
    
    public func getToken(){
        if let token = Messaging.messaging().fcmToken {
            print(token)
        }
    }
}
