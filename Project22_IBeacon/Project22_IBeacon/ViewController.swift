//
//  ViewController.swift
//  Project22_IBeacon
//
//  Created by Ильдар Нигметзянов on 11.05.2020.
//  Copyright © 2020 Ильдар Нигметзянов. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceReading: UILabel!
    
    var locationManager: CLLocationManager?
    var shown = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
        view.backgroundColor = .gray
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                    startScanning()
                }
            }
        }
    }
    
    func startScanning(){
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123,minor: 456,identifier: "MyBeacon")
        
        let beaconRegion2 = CLBeaconRegion(proximityUUID: uuid, major: 124,minor: 457,identifier: "MyBeacon")
        
        locationManager?.stopMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
        
        locationManager?.stopMonitoring(for: beaconRegion2)
        locationManager?.startRangingBeacons(in: beaconRegion2)
    }
    
    func update(distance: CLProximity){
        UIView.animate(withDuration: 1){
            
            switch distance{
            case .unknown:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "UNLNOWN"
                UIView.animate(withDuration: 1, delay: 0, options: [], animations:{ self.distanceReading.transform = CGAffineTransform(scaleX: 2, y: 2)
                }, completion: nil)
            case .far:
                self.view.backgroundColor = UIColor.gray
                self.distanceReading.text = "FAR"
            case .near:
                self.view.backgroundColor = UIColor.orange
                self.distanceReading.text = "NEAR"
            case .immediate:
                self.view.backgroundColor = UIColor.red
                self.distanceReading.text = "RIGHT HERE"
            default:
                self.view.backgroundColor = .black
                self.distanceReading.text = "WHOA!"
            }
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        
        
        if let beacon = beacons.first{
            if beacon.major == 124 {
                print("second")
            } else {
                print("first")
            }
            if shown {
            let ac = UIAlertController(title: "First beacon", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac,animated: true)
            }
            shown = false
            update(distance: beacon.proximity)
        } else {update(distance: .unknown)}
        
        
    }

}

