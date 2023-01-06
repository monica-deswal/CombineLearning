//
//  Notification_Part1.swift
//  Combine_Part1
//
//  Created by Monica Deshwal on 04/01/23.
//

import Foundation

struct Notification_Part1 {
    
    
    //Functional programming
    func availabePublisherAndSubscriberPatter() {
        
        let notification = Notification.Name("MyNotification")
        
        let center = NotificationCenter.default
        
        let observer = center.addObserver(forName: notification
                                          , object: nil
                                          , queue: nil) { notification in
            print("Notification Received")
        }
        
        center.post(name:notification
                    , object: nil)
        
        center.removeObserver(observer)
    }
    
    func sendNotificationUsingPubSub() {
        
        let notification = Notification.Name("PubSubNotification")
        
        let publisher = NotificationCenter.default.publisher(for: notification)
        
        //AnyCancellable
        let subscription = publisher.sink { _ in
            print("Notification received")
        }
        
        NotificationCenter.default.post(name: notification, object: nil)
        
        subscription.cancel()
    }
}
