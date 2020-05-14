//
//  ViewController.swift
//  Project5
//
//  Created by Ильдар Нигметзянов on 31.03.2020.
//  Copyright © 2020 Ildar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var allWords = [String]()
    var usedWords = [String]()
    var localScore = 0
    var localWord = ""
    var firstGame = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        usedWords = userDefaults.array(forKey: "Array") as? [String] ?? [String]()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                allWords = startWords.components(separatedBy: "\n")
            }
        }
        
        if allWords.isEmpty{
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(usedWords, forKey: "Array")
        var title1 = [String]()
        title1.append(self.title!)
        userDefaults.set(title1, forKey: "Title")
        userDefaults.set(true, forKey: "ClosedApp")
    }
    
    @objc func startGame(){
        let defaults = UserDefaults.standard
        if firstGame {
        defaults.set(usedWords.count, forKey: "Score")
        }
        firstGame = false
        let score = defaults.integer(forKey: "Score")
        
        if localScore > score && localScore != 0 {
            let alert = UIAlertController(title: "New score", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert,animated: true)
            defaults.set(usedWords.count, forKey: "Score")
        }
        
        localScore = 0
        
        if !defaults.bool(forKey: "ClosedApp"){
            localWord = allWords.randomElement()!
            usedWords.removeAll(keepingCapacity: true)
        } else {
            let title1 = defaults.array(forKey: "Title") as! [String]
            title = title1[0]
            defaults.set(false, forKey: "ClosedApp")
            return
        }
        title = "\(localWord)"+" \(usedWords.count)"
        tableView.reloadData()
        
        
    }

    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac](action) in
            guard let answer = ac?.textFields?[0].text else {
                return
                
            }
            self?.submit(answer)
        }
        
        ac.addAction(submitAction)
        present(ac,animated: true)
    }
    
    func submit(_ answer: String){
        let lowerAnswer = answer.lowercased()
        
        let errorTitle :String
        let errorMessage : String
        
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer){
                if isReal(word: lowerAnswer){
                    usedWords.insert(answer.lowercased(), at: 0)
                    localScore += 1
                    title = "\(localWord)"+" \(localScore)"
                
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                    
                    return
                }else {
                    errorTitle = "Word not recognised"
                    errorMessage = "You can't just make them up,you know!"
                    showErrorMessage(title: errorTitle, message: errorMessage)
                }
            }else {
                errorTitle = "Word used already"
                errorMessage = "Be more original!"
                showErrorMessage(title: errorTitle, message: errorMessage)
            }
        }else {
            guard let title = title?.lowercased() else {
                return
            }
            errorTitle = "Word not possible"
            errorMessage = "You can't spell that word from \(title)"
            showErrorMessage(title: errorTitle, message: errorMessage)
        }
    }
    
    func showErrorMessage(title:String,message:String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac,animated: true)
    }
    
    func isPossible(word: String) -> Bool {
        guard var tempWord = title?.lowercased() else {
            return false
        }
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter){
                tempWord.remove(at: position)
            }else {
                return false
            }
        }
        
        return true
    }
    
    func isOriginal(word: String) -> Bool{
        return !usedWords.contains(word)
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound && word.count > 3 && word != title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }

}

