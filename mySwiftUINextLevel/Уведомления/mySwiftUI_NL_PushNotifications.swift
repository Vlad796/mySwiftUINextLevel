//
//  mySwiftUI_NL_PushNotifications.swift
//  mySwiftUINextLevel
//
//  Created by Влад Варламов on 14.02.2025.
//

import SwiftUI
import UserNotifications
import CoreLocation

/*
 Для того что бы просто отправлять сообщение на разрешение уведомлений,
 необходимо прописать класс с синголтоном, который будет содержать функцию с обработкой этого уведомления.

 UNUserNotificationCenter - центр уведомлений в приложении
 
 Если нажать повторно на кнопку вызова уведомления, то оно не появится, так как уже было дано разрешение на уведомления
 
 UNMutableNotificationContent  - содержимое уведомления
*/
 
class notificationManager {
    static let shared = notificationManager()   //Синголтон
    
    //Функция для вопроса о уведомлении
    func registerForRemoteNotifications() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]  //прописывается для определения параметров уведомления.
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("Error registering for remote notifications: \(error)")
            } else {
                print("Successfully registered for remote notifications.")
            }
        }
    }
    
    //Функция для отправки уведомлений
    func sendingNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "This my first notificatoin"
        content.subtitle = "I fink it is good"
        content.sound = .default
        content.badge = 1
        
//Тригеры
    //TimeTrigger
//        let time = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
    //CalendarTrigger
//        var dateComponents = DateComponents()
//        dateComponents.hour = 20
//        dateComponents.minute = 26
//        let calendar = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
    //LocationTrigger
        let center = CLLocationCoordinate2D(latitude: 40.00, longitude: 50.00)
        let region = CLCircularRegion(
            center: center,       //Нужны координаты для этого пункта
            radius: 100,       //Расстояние от центра, в метрах
            identifier: UUID().uuidString       //Опять нужен id уведомлений
        )
        region.notifyOnEntry = true     //запуск при попадании в зону радиуса
        region.notifyOnExit = false     //запуск при выходе из заны радиуса
        let location = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,    //Нужен если будет сохранение уведомлений где нибудь в приложении
            content: content,
            trigger: location       //То из-за чего будет запускаться уведомление
        )
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()       //удалить все ожидающие уведомления
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()        //удалить все доставленные уведомления
    }
}

struct mySwiftUI_NL_PushNotifications: View {
    var body: some View {
        VStack(spacing: 20) {
            Button {
                notificationManager.shared.registerForRemoteNotifications()
            } label: {
                Text("Press for to allow notifications")
            }
            
            Button {
                notificationManager.shared.sendingNotifications()
            } label: {
                Text("Press for push notification")
            }
            
            Button {
                notificationManager.shared.cancelAllNotifications ()
            } label: {
                Text("Press for cancel notification")
            }
        }
        .onAppear{
            UNUserNotificationCenter.current().setBadgeCount(0, withCompletionHandler: nil)     //Строка для обнуления значка уведомлений на иконке приложения
        }
    }
}

#Preview {
    mySwiftUI_NL_PushNotifications()
}
