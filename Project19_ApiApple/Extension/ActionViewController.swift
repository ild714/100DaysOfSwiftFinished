//
//  ActionViewController.swift
//  Extension
//
//  Created by Ильдар Нигметзянов on 10.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    var text : String = ""
    var example1 : String = ""
    
    
    @IBAction func chooseFromTable(_ sender: Any) {
    }
    @IBAction func saveInTable(_ sender: Any) {
        let st = storyboard?.instantiateViewController(identifier: "Table") as! ViewController
        st.texts.append(script.text)
        
        navigationController?.pushViewController(st, animated: true)
    }
    @IBOutlet weak var save: UIButton!
    @IBOutlet weak var script: UITextView!
    var pageTitle = ""
    var pageURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.script.text = text
        
        let notificationCenter = NotificationCenter.default
               notificationCenter.addObserver(self,selector: #selector(adjustForKeyboard),name:UIResponder.keyboardWillHideNotification,object:nil)
               notificationCenter.addObserver(self,selector: #selector(adjustForKeyboard),name:UIResponder.keyboardWillChangeFrameNotification,object:nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(example))
        if let inputItem = extensionContext?.inputItems.first as? NSExtensionItem{
            if let itemProvider = inputItem.attachments?.first{
                itemProvider.loadItem(forTypeIdentifier: kUTTypePropertyList as String){[weak self] (dict,error) in
                    guard let itemDictionary = dict as? NSDictionary else {return}
                    guard let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as? NSDictionary else {return}
                    self?.pageTitle = javaScriptValues["title"] as? String ?? ""
                    self?.pageURL = javaScriptValues["URL"] as? String ?? ""
                    
                    let url = URL(string: self?.pageURL ?? "")!
                    self?.example1 = url.host ?? ""
                    UserDefaults.standard.set(url.host, forKey: "Url")
                    
                    DispatchQueue.main.async {
                        self?.title = self?.pageTitle
                    }
                }
            }
        }
    }

    @objc func example(){
        let ac = UIAlertController(title: "Example code", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Example 1", style: .default, handler: { (test) in
            self.script.text = "alert(document.title)"
            
        }))
        
        present(ac,animated: true)
    }
    
    @objc func adjustForKeyboard(notification: Notification){
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame,from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            script.contentInset = .zero
        } else {
            script.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        script.scrollIndicatorInsets = script.contentInset
        
        let selectedRange = script.selectedRange
        script.scrollRangeToVisible(selectedRange)
    }

    
    @IBAction func done() {
        let item = NSExtensionItem()
        let argument: NSDictionary = ["customJavaScript":script.text]
        let webDictionary: NSDictionary = [NSExtensionJavaScriptFinalizeArgumentKey:argument]
        let customJavaScript = NSItemProvider(item: webDictionary, typeIdentifier: kUTTypePropertyList as String)
        item.attachments = [customJavaScript]
        
        extensionContext?.completeRequest(returningItems: [item])
        
        let data = UserDefaults.standard.url(forKey: "Url")!
        print(data)
        print("ok")
    }

}
