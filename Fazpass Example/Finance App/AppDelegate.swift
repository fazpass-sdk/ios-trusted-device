//
//  AppDelegate.swift
//  Finance App
//
//  Created by Akbar Putera on 02/02/23.
//

import UIKit
import Fazpass
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fazpass.shared.initialize(SecretConstant.merchantKey, .DEV)
        Fazpass.shared.permissionCheck()
        let pushManager = PushNotificationManager(userID: "")
        FirebaseApp.configure()
        
        pushManager.registerForPushNotifications()
        
        return true
    }
}
