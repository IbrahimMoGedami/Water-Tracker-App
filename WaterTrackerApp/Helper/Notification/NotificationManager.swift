//
//  NotificationManager.swift
//  WaterTrackerApp
//
//  Created by Ibrahim Gedami on 28/06/2025.
//

import Foundation
import UserNotifications

//class NotificationManager {
//    
//    static let shared = NotificationManager()
//    private init() {}
//    
//    func requestPermission() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
//    }
//    
//    func scheduleHourlyNotifications(from startHour: Int = 4, to endHour: Int = 22) {
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//        for hour in startHour..<endHour {
//            let content = UNMutableNotificationContent()
//            content.title = "💧 Time to Hydrate"
//            content.body = "Drink about 222ml of water now."
//            content.sound = .default
//            
//            var components = DateComponents()
//            components.hour = hour
//            components.minute = 0
//            
//            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
//            let request = UNNotificationRequest(identifier: "water_\(hour)", content: content, trigger: trigger)
//            
//            UNUserNotificationCenter.current().add(request)
//        }
//    }
//
//}

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationManager()
    private override init() {}

    func scheduleRepeatingMinuteNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "💧 Time to Hydrate"
        content.body = "Drink 222ml of water now!"
        content.sound = .default
        content.sound = UNNotificationSound(named: UNNotificationSoundName("water_ding.wav"))
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        let request = UNNotificationRequest(identifier: "minute_water_reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                debugPrint("🔴 Failed to schedule notification:", error)
            } else {
                debugPrint("✅ Minute-based notification scheduled.")
            }
        }
    }

}
