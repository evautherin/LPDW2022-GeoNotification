//
//  NotificationCenterDelegate.swift
//  Notification
//
//  Created by Etienne Vautherin on 04/02/2022.
//

import Foundation
import UserNotifications
import UserNotificationsUI
import CoreLocation


class NotificationCenterDelegate: NSObject {
    static let shared = NotificationCenterDelegate()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }
    
}


extension NotificationCenterDelegate: UNUserNotificationCenterDelegate {
    
    class func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if granted {
                print("Notifications granted")
            } else {
                print("Notifications denied")
            }
            
        }
    }
    
    class func regionNotify(region: CLRegion) {
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        let content = UNMutableNotificationContent()
        content.title = "My First Notification"
        content.body = "Hello from Notification Service"
        let request = UNNotificationRequest(identifier: "NotifIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            print("regionNotify: \(region)")
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }

    class func timeNotify() {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = "My First Notification"
        content.body = "Hello from Notification Service"
        let request = UNNotificationRequest(identifier: "NotifIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
}
