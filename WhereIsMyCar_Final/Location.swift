//
//  Location.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 15/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

/** Location model object*/
public class Location{
    
    // Attributes
    public var title: String
    public var comment : String
    public var longitude: Double
    public var latitude: Double
    public var altitude: Double
    
    
    init(title:String, comment:String, longitude:Double, latitude:Double, altitude:Double) {
        
        self.title = title
        self.comment = comment
        self.longitude = longitude
        self.latitude = latitude
        self.altitude = altitude
    }
}
	
