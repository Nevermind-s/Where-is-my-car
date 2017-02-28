//
//  DetailsController.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 17/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

import UIKit
import CoreLocation

class DetailsController: UIViewController {
    
    //Text labels used to display details
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var commentLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    
    //Attributes used to store details
    public var latitude:Double = 0.0
    public var longitude: Double = 0.0
    public var titleZone: String = ""
    public var comment: String = ""
    public var altitude: Double = 0.0
    public var location:Location?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setting the label to display location details.
        titleLabel.text = self.titleZone
        commentLabel.text = self.comment
        latitudeLabel.text = "Latitude: " + String(self.latitude)
        longitudeLabel.text = "Longitude: " + String(self.longitude)
        altitudeLabel.text = "Altitude: " + String(self.altitude)

    }
    /** 
    Create a CLLocation object from location coordinates.
    - returns: zoneLocation as a CLLocation used in other methods.
     */
    func makeLocation() -> CLLocation {
        let zoneLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
        return zoneLocation
    }

    @IBAction func goToZone(_ sender: Any) {
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    // Used by ZoneViewController to set the details from the selected row
    func setValues(latitude: Double, longitude: Double, titleZone:String, comment:String, altitude:Double) {
        self.latitude = latitude
        self.longitude = longitude
        self.altitude = altitude
        self.titleZone = titleZone
        self.comment = comment
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let guest = segue.destination as! DetailsZone
        guest.currentPosition = makeLocation()
        
    }
}
