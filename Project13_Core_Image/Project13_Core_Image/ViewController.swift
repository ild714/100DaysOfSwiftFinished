//
//  ViewController.swift
//  Project13_Core_Image
//
//  Created by Ильдар Нигметзянов on 08.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet weak var radius: UISlider!
    @IBOutlet weak var buttonFilter: UIButton!
    @IBOutlet weak var intensity: UISlider!
    @IBOutlet weak var imageView: UIImageView!
    var currentImage: UIImage!
    var context: CIContext!
    var currentFilter: CIFilter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "YACIFP"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        
        context = CIContext()
        currentFilter = CIFilter(name: "CISepiaTone")
    }
    
    @IBAction func changeFilter(_ sender: Any) {
        let ac = UIAlertController(title: "Choose filrer", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "CIBumpDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIGaussianBlur", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIPixellate", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CISepiaTone", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CITwirlDistortion", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIUnsharpMask", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "CIVignette", style: .default, handler: setFilter))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac,animated: true)
    }
    @IBAction func save(_ sender: Any) {
        guard let image = imageView.image else {
            let ac = UIAlertController(title: "Save error", message: "No image was provided", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            present(ac,animated: true)
            return}
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer){
        if let error = error{
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            present(ac,animated: true)
        } else {
            let ac = UIAlertController(title: "Saved", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            present(ac,animated: true)
        }
    }
    
    @IBAction func intensityChanged(_ sender: Any) {
        applyProcessing()
    }
    
    @IBAction func radiusChanged(_ sender: Any) {
        applyProcessing()
    }
    func setFilter(action: UIAlertAction){
        guard currentImage != nil else {return}
        guard let actionTitle = action.title else {return}
        
        
        currentFilter = CIFilter(name: actionTitle)
        buttonFilter.setTitle(actionTitle, for: .normal)

        
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        applyProcessing()
    }
    
    @objc func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        dismiss(animated: true)
//        currentImage.ish
        
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            self.imageView.alpha = 0
        }) { (no) in

        }

        currentImage = image
               
        let beginImage = CIImage(image: currentImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        
        
        
        applyProcessing()
    }
    
    func applyProcessing(){
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){currentFilter.setValue(intensity.value, forKey:kCIInputIntensityKey)}
        if inputKeys.contains(kCIInputRadiusKey ){currentFilter.setValue(radius.value * 200, forKey:kCIInputRadiusKey)}
         if inputKeys.contains(kCIInputScaleKey){currentFilter.setValue(intensity.value * 10, forKey:kCIInputScaleKey)}
        if inputKeys.contains(kCIInputCenterKey){currentFilter.setValue(CIVector(x:currentImage.size.width / 2,y:currentImage.size.height / 2), forKey:kCIInputCenterKey)}
        
        if let cgimg = context.createCGImage(currentFilter.outputImage!, from: currentFilter.outputImage!.extent){
            let proccessedImage = UIImage(cgImage: cgimg)
            UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
                self.imageView.alpha = 1
            }) { (no) in
                
            }
            
            imageView.image = proccessedImage
        }
    }
}

