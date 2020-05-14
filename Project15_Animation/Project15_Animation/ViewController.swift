//
//  ViewController.swift
//  Project15_Animation
//
//  Created by Ильдар Нигметзянов on 08.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            [unowned self] in
            self.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

class ViewController: UIViewController {

    var imageView: UIImageView!
    var currentAnimation = 0
    
    @IBAction func tapped(_ sender: UIButton) {
//        sender.isHidden = true
        imageView.bounceOut(duration: 10)
//        UIView.animate(withDuration: 1, delay: 0,usingSpringWithDamping: 0.5,initialSpringVelocity: 15, options: [], animations: {
//            switch self.currentAnimation{
//            case 0:
//                self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
//            case 1: self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
////                self.imageView.transform = .identity
//            case 2:
//                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
//            case 3: self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)//                self.imageView.transform = .identity
//            case 4:
//                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
//            case 5:
//                self.imageView.transform = .identity
//            case 6:
//                self.imageView.alpha = 0.1
//                self.imageView.backgroundColor = UIColor.green
//            case 7:
//                self.imageView.alpha = 1
//                self.imageView.backgroundColor = UIColor.clear
//            default:
//                break
//            }
//        }) { (finished) in
//            sender.isHidden = false
//        }
        
        currentAnimation += 1
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "whell"))
        imageView.center = CGPoint(x: 512, y: 384)
        view.addSubview(imageView)
    }


}

