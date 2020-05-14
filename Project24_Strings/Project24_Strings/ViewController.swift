//
//  ViewController.swift
//  Project24_Strings
//
//  Created by Ильдар Нигметзянов on 12.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let name = "Taylor"
        
//        let letter = name[name.index(name.startIndex,offsetBy: 3)]
//        print(letter)
//        name[3] = "r"
//        print(name[3])
//        print(name.hasPrefix("Ta"))
//        print(name.deletingPrefix("Ta"))
//        let languages = ["swift","c","c++"]
//        let input = "swift"
//        print(languages.contains(where: input.contains))
//
//        let string = "This is a test string"
//        let attributes : [NSAttributedString.Key:Any] = [
//            .foregroundColor: UIColor.white,
//            .backgroundColor: UIColor.red,
//            .font: UIFont.boldSystemFont(ofSize: 36)]
//        let attributedString = NSAttributedString(string: string, attributes: attributes)
        
//        print(input.withPrefix("learn"))
//        var test = "gf"
//        print(test.isNumeric())
        var test2 = #"this\nis\na\ntest"#
        print(test2.splitLine())
        
//        print(test2.split(separator: "\"))
//        print("6 times 7 is \(6 * 7).")
    }
    
}

extension String {
    func splitLine() -> [String] {
        var str : String = ""
        for i in self {
            if i != (#"\"#) {
                str += String(i)
            } else {
                str += String("/")
            }
        }
        
        let str1 = String(str)
        let subStr = str1.split(separator: "/")
        var mas = [String]()
        for i in subStr {
            mas.append(String(i))
        }
        return mas
    }
}

extension String {
    mutating func isNumeric() -> Bool {
        for i in self {
            if let value = Double(self.first!.uppercased()){
              return true
            }
            self.removeFirst()
        }
        return false
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex,offsetBy: i)])
    }
}

extension String {
    func deletingPrefix(_ prefix: String) -> String{
        guard self.hasPrefix(prefix) else {return self}
        return String(self.dropFirst(prefix.count))
    }
    
    func deletingSuffix(_ suffix: String) -> String{
        guard self.hasSuffix(suffix) else {return self}
        return String(self.dropLast(suffix.count))
    }
}

extension String {
    func withPrefix(_ prefix: String ) -> String {
        if self.hasPrefix(prefix) {
            return self
        } else {
            return prefix + self
        }
    }
}

extension String {
    var capitalizedFirst: String {
        guard let firstLetter = self.first else {return ""}
        return firstLetter.uppercased() + self.dropFirst()
    }
}
