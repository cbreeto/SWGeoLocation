//
//  ViewController.swift
//  geoLoc
//
//  Created by Carlos Brito on 26/12/15.
//  Copyright © 2015 Carlos Brito. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var norteGeo: UILabel!
    @IBOutlet weak var norteMgn: UILabel!
    @IBOutlet weak var horizontalLbl: UILabel!
    @IBOutlet weak var longitudLbl: UILabel!
    @IBOutlet weak var latitudLbl: UILabel!
    
    private let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
    }

    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
            
            //brújula
            manager.startUpdatingHeading()
        }
        else {
            manager.stopUpdatingLocation()
            //stop brújula
            manager.stopUpdatingHeading()
        }
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        latitudLbl.text = "\(manager.location!.coordinate.latitude)"
        longitudLbl.text = "\(manager.location!.coordinate.longitude)"
        horizontalLbl.text = "\(manager.location!.horizontalAccuracy)"
        
    }

    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
       
        let alert = UIAlertController(title: "Error", message: "Error \(error.code)", preferredStyle: .Alert)
        let actionOk = UIAlertAction(title: "Ok", style: .Default, handler: {
            action in
            //..
        })
        
        
        alert.addAction(actionOk)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    //brújula reading
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        norteMgn.text = "\(newHeading.magneticHeading)"
        norteGeo.text = "\(newHeading.trueHeading)"
    }
}

