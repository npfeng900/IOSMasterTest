//
//  ViewController.swift
//  WhereAmI
//
//  Created by Niu Panfeng on 22/11/2016.
//  Copyright © 2016 NaPaFeng. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var horizontalAccuracyLabel: UILabel!
    @IBOutlet weak var verticalAccuracyLabel: UILabel!
    @IBOutlet weak var distanceTraveledLabel: UILabel!
    
    private let locationManager = CLLocationManager()
    private var previousPoint:CLLocation!
    private var totalMovementDistance:CLLocationDistance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //授权状态更改时
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        //注意在info.plist中添加NSLocationWhenInUseUsageDescription / NSLocationAlwaysUsageDescription属性
        switch status
        {
        case .Authorized, .AuthorizedWhenInUse:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
        default:
            locationManager.stopUpdatingLocation()
            mapView.showsUserLocation = false
            
        }
    }
    //读取位置出错时
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let errorType = ( error.code == CLError.Denied.rawValue ? "Access Denied" : "Error \(error.code)" )
        let alertController = UIAlertController(title: "Location Manager Error", message: errorType, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Cancel, handler: {(action) -> Void in})
        alertController.addAction(okAction)
        presentViewController(alertController, animated: true, completion: nil)
    }
    //更新位置时
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let newLocation = locations[locations.count - 1]
        if newLocation.horizontalAccuracy < 0 {
            // invalid accuracy
            return
        }
        
        if newLocation.horizontalAccuracy > 100 || newLocation.verticalAccuracy > 50 {
                // accuracy radius is so large, we don't want to use it
                return
        }
        
        if previousPoint == nil {
            totalMovementDistance = 0
            let start = Place(title: "开始点", subtitle: "这是你开始的地方", coordinate: newLocation.coordinate)
            mapView.addAnnotation(start)
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 300, 300)
            mapView.setRegion(region, animated: true)
        
        } else {
            
            let start = Place(title: "ME", subtitle: "我在跑", coordinate: newLocation.coordinate)
            mapView.addAnnotation(start)
            
            let region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 300, 300)
            mapView.setRegion(region, animated: true)
            
            print("movement distance: " + "\(newLocation.distanceFromLocation(previousPoint))")
            totalMovementDistance += newLocation.distanceFromLocation(previousPoint)
        }
        previousPoint = newLocation
        
        latitudeLabel.text = String(format: "%g\u{00B0}", newLocation.coordinate.latitude)
        longtitudeLabel.text = String(format: "%g\u{00B0}", newLocation.coordinate.longitude)
        altitudeLabel.text = String(format: "%g\u{00B0}", newLocation.altitude)
        horizontalAccuracyLabel.text = String(format:"%gm", newLocation.horizontalAccuracy)
        verticalAccuracyLabel.text = String(format:"%gm", newLocation.verticalAccuracy)
        distanceTraveledLabel.text =  String(format:"%gm", totalMovementDistance)
    }

}

