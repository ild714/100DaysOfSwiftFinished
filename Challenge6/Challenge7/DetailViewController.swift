//
//  DetailViewController.swift
//  Challenge7
//
//  Created by Ильдар Нигметзянов on 11.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    var notes: [Note]!
    var index = 0
    
    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.text = notes[index].text
        self.textField.delegate = self
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,selector: #selector(adjustForKeyboard),name:UIResponder.keyboardWillHideNotification,object:nil)
        notificationCenter.addObserver(self,selector: #selector(adjustForKeyboard),name:UIResponder.keyboardWillChangeFrameNotification,object:nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))
    }
    
    @objc func adjustForKeyboard(notification: Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame,from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            textField.contentInset = .zero
        } else {
            textField.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        textField.scrollIndicatorInsets = textField.contentInset
        
        let selectedRange = textField.selectedRange
        textField.scrollRangeToVisible(selectedRange)
    }
    
    @objc func share() {
        let ac = UIActivityViewController(activityItems: [notes[index].text], applicationActivities: nil)
        present(ac,animated: true)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        closeController()
    }
    
    func closeController(){
        let st = storyboard?.instantiateViewController(identifier: "Main") as! ViewController
        self.notes[index].text = textField.text
        st.notes = self.notes
        save()
    }
    
    func save(){
        let defaults = UserDefaults.standard
        
        let jsonEncoder = JSONEncoder()
        
        if let data = try? jsonEncoder.encode(notes){
            defaults.set(data, forKey: "Data")
        } else {
            fatalError("Could not to write data")
        }
    }

}
