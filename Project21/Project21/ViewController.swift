//
//  ViewController.swift
//  Project21
//
//  Created by Ильдар Нигметзянов on 11.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Register", style: .plain, target: self, action: #selector(registerLocal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Schedule", style: .plain, target: self, action: #selector(scheduleLocal))
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Yay!")
            } else {
                print("D'oh")
            }
        }
    }
    
    @objc func scheduleLocal(){
        registerCategories()
        let center = UNUserNotificationCenter.current()
        
//        var dataComponents = DateComponents()
//        dataComponents.hour = 10
//        dataComponents.minute = 30
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dataComponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Title goes here"
        content.body = "Main text goes here "
        content.categoryIdentifier = "alarm"
        content.userInfo = ["customData":"fizzbuzz"]
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
        
//        center.removeAllPendingNotificationRequests()
    }
    
    func registerCategories(){
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        
        let show = UNNotificationAction(identifier: "show", title: "Tell me more...", options: .foreground)
        let close = UNNotificationAction(identifier: "later", title: "Remind me later", options: [])
        let category = UNNotificationCategory(identifier: "alarm", actions: [show,close], intentIdentifiers: [])
        center.setNotificationCategories([category])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let customData = userInfo["customData"] as? String{
            print("Custom data received: \(customData)")
            
            switch response.actionIdentifier {
            case UNNotificationDefaultActionIdentifier:
                print("Default identifier")
            case "show":
                let al = UIAlertController(title: "Show button was tapped", message: nil, preferredStyle: .actionSheet)
                al.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present(al,animated: true)
                print("Show more informaton...")
            case "later":
                self.scheduleLocal()
            default:
                break
            }
        }
        completionHandler()
    }
}

