//
//  DetailsZone.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 24/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailsZone: UIViewController {

    @IBOutlet var mapViewZone: MKMapView!
    var currentPosition:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRegion(location: currentPosition!)
        pinIt(location: currentPosition!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Point the Map's camera to a locations's region.
     
     - Parameter location: The location we want to show in our Map.
     */
    func setRegion (location: CLLocation) {
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.8, 0.8)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapViewZone.setRegion(region, animated: true)
    }
    
    /**
     
     Create an annotation on the added point on the map and put a small red pin on it
     
     - Parameter location: Location model that contains informations and coordinates of the new position.
     
     */
    func pinIt (location: CLLocation) {
        let myPinLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let pin = MKPointAnnotation()
        pin.coordinate = myPinLocation
        pin.title = "Title"
        pin.subtitle = "comment"
        mapViewZone.addAnnotation(pin)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
