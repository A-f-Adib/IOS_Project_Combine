//
//  UserNotification.swift
//  new.SwT
//
//  Created by A.f. Adib on 1/6/24.
//

import SwiftUI
import UserNotifications

struct UserNotification: View {
    var body: some View {
        VStack {
            Button("Request Permission ") {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        print("All set!")
                    } else if let error = error {
                        print(error.localizedDescription)
                    }
                }
            }
            
            
            Button("Schedule Notification") {
                let content = UNMutableNotificationContent()
                content.title = "Feed the dogs"
                content.subtitle = "They Looks hungry"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            }
        }
    }
}

struct UserNotification_Previews: PreviewProvider {
    static var previews: some View {
        UserNotification()
    }
}
