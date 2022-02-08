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
        let notificationCenter = UNUserNotificationCenter.current()
            
        notificationCenter.removeAllPendingNotificationRequests()
        
        region.notifyOnEntry = true
        region.notifyOnExit = false
        let triggerEnter = UNLocationNotificationTrigger(region: region, repeats: true)
        let contentEnter = UNMutableNotificationContent()
        contentEnter.title = "Enter Notification"
        contentEnter.body = "You're entering \(region.identifier)"
        
        let requestEnter = UNNotificationRequest(identifier: "Enter", content: contentEnter, trigger: triggerEnter)
        notificationCenter.add(requestEnter) { error in
            print("regionNotify enter: \(region)")
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        
        region.notifyOnEntry = false
        region.notifyOnExit = true
        let triggerExit = UNLocationNotificationTrigger(region: region, repeats: true)
        let contentExit = UNMutableNotificationContent()
        contentExit.title = "Exit Notification"
        contentExit.body = "You're exiting \(region.identifier)"
        
        let requestExit = UNNotificationRequest(identifier: "Exit", content: contentExit, trigger: triggerExit)
        notificationCenter.add(requestExit) { error in
            print("regionNotify exit: \(region)")
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        notificationCenter.getPendingNotificationRequests { requests in
            print("NotificationRequests: \(requests)")
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


extension NotificationCenterDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        print("didReceive notification \(response.notification.request.identifier)")
        completionHandler()
    }
    
    
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        print("willPresent notification \(notification.request.identifier)")
        completionHandler([.badge, .banner, .sound])
    }
}
