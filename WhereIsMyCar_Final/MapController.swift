//
//  MapController.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 15/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit
import CoreData

/// A Controller for the home page map that implements "MKMapViewDelegate" & "CLLocationManagerDelegate" in order to get user location (Fake location in case of simulator use)

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate	{

    @IBOutlet var mapView: MKMapView!
    
    var location:[Location]?
    var currentPosition:CLLocation?
    
    /* Object type CLLocationManager will allow us to get and update current user location */
    let locationManager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Initialization of the location manager by delegatinf the context of this controller */
        self.locationManager.delegate = self
        
        /* Setting the location manager accuracy to "kCLLocationAccuracyBest" */
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        /* Trigger a authorization request to access user location */
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        mapView.removeAnnotations(mapView.annotations)
        for zone in CoreDataHandler.fetchObj() {
            self.pinIt(location: zone)
        }
    }
    
    
    @IBAction func goToBookZone(_ sender: Any) {
        let bookZone: ZoneViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "zoneController") as! ZoneViewController
        bookZone.initLocation(locations: CoreDataHandler.fetchObj())
        self.show(bookZone, sender: nil)
    }
    
    // Display a popup to add a title and a comment to the current user position
    @IBAction func addZone(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add New Zone", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        /**Save action will add the current location and the input in the core data
            and add a pin on it */
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default, handler: {
            alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            //kkkkkkk
            CoreDataHandler.storeObj(title: firstTextField.text!, comment: secondTextField.text!, location: self.currentPosition!)
            self.pinIt(location: (CoreDataHandler.fetchObj()[(CoreDataHandler.fetchObj().endIndex) - 1]))})
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {
            (action : UIAlertAction!) -> Void in})
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Title" }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Description"   }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        getCurrentPosition(location: location)
        setRegion(location: currentPosition!)
        self.mapView.showsUserLocation = true
        
    }
    
    /**
     Point the Map's camera to a locations's region.
 
     - Parameter location: The location we want to show in our Map.
     */
    func setRegion (location: CLLocation) {
        let span:MKCoordinateSpan = MKCoordinateSpanMake(1, 1)
        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
    }
    
    /**
     
     Create an annotation on the added point on the map and put a small red pin on it
     
     - Parameter location: Location model that contains informations and coordinates of the new position.
     
     */
    func pinIt (location:Location) {
        let myPinLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(CLLocationDegrees(location.latitude), CLLocationDegrees(location.longitude))
        let pin = MKPointAnnotation()
        pin.coordinate = myPinLocation
        pin.title = location.title
        pin.subtitle = location.comment
        mapView.addAnnotation(pin)
    }

    /**
     
     Put out the current location of the user from the location manager to a public range and on thread safe object
     
     - Parameter location: User current location passed from the location manager.
     
     */    func getCurrentPosition(location:CLLocation) {
        self.currentPosition = location
    }
    

}
