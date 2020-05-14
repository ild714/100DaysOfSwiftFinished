//
//  ViewController.swift
//  Project2
//
//  Created by Ильдар Нигметзянов on 19.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert,.sound,.badge]
        center.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notitifications")
            }
        }
        createNotification()
        countries += ["estonia","france","germany","ireland","italy","monaco","nigeria","poland","russia","spain","uk","us"]
        
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        correctAnswer = Int.random(in:0...2)
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        UIView.animate(withDuration: 0, delay: 0, options: [], animations: {
            self.button1.transform = .identity
            self.button2.transform = .identity
            self.button3.transform = .identity
        }) { (no) in
            
        }
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = countries[correctAnswer].uppercased() + " | score:\(score)"
        
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { (no) in
            
        }
        
        
        if sender.tag == correctAnswer{
            title = "Correct"
            if counter == 2 {
                
                let ac1 = UIAlertController(title: "Finish", message: "Your score is \(score).", preferredStyle: .alert)
                ac1.addAction(UIAlertAction(title: "Ok", style: .default, handler: askQuestion))
                present(ac1,animated: true)
                score = 0
                counter = 0
                return
            }else {
                score+=1
                
                
            }
        }else {
            title = "Wrong"
            
            if counter == 2 {
                
                let ac1 = UIAlertController(title: "Finish, it was \(countries[sender.tag])", message: "Your score is \(score).", preferredStyle: .alert)
                ac1.addAction(UIAlertAction(title: "Ok", style: .default, handler: askQuestion))
                present(ac1,animated: true)
                score = 0
                counter = 0
                return
            }else {
                counter += 1
                let ac2 = UIAlertController(title: "No", message: "It is \(countries[sender.tag]).", preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "Ok", style: .default, handler: askQuestion))
                present(ac2,animated: true)
                return
            }
            
        }
        
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
        if counter == 2 {
            
            let ac1 = UIAlertController(title: "Finish", message: "Your score is \(score).", preferredStyle: .alert)
            ac1.addAction(UIAlertAction(title: "Ok", style: .default, handler: askQuestion))
            present(ac1,animated: true)
            score = 0
            counter = 0
            return
        }
        counter+=1
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac,animated: true)
    }
    
    func createNotification(){
        let center = UNUserNotificationCenter.current()
        self.addActionToNotification()
//        var data = DateComponents()
//
//        data.day = 11
//        data.year = 2020
//        data.month = 5
        
//        let data = Data()
        
//        let triggerDate = Calendar.current.date(from: data)
//        let trigger =  UNCalendarNotificationTrigger(dateMatching: data, repeats: false)
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Play game every day"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "Local Notification"
        
        let request = UNNotificationRequest(identifier: "Local Notification", content: content, trigger: trigger)
        center.add(request)
    }
    
    func addActionToNotification(){
        
        
        
        let open = UNNotificationAction(identifier: "open", title: "open", options: .foreground)
        let close = UNNotificationAction(identifier: "close", title: "close", options: .destructive)
        let category = UNNotificationCategory(identifier: "Local Notification", actions: [open,close], intentIdentifiers: [], options: [])
        
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([category])
        center.delegate = self
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "Local Notification" {
            
        }
        
        switch response.actionIdentifier {
        case "close":
            self.createNotification()
        default:
            break
        }
        completionHandler()
    }
    
}

