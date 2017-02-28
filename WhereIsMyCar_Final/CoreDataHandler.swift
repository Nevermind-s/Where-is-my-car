//
//  CoreDataHandler.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 22/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData


/** Using to handle actions on the CoreData's entities*/
class CoreDataHandler: NSObject {
    /**
        Specify the context from where CoreDataHandler is instanciated 
     	- returns: NSManagedObjectContext
     */
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    /**
    Store the added location on the entity.
     - Parameters:
        - title: Title of the location.
        - comment: Comment added by the user to describe the added postion.
        - location: CLLocation object that contains longitude, latitude and altitude attributes.
 */
    class func storeObj(title:String,comment:String, location:CLLocation) {
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Zones", in: context)
        
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(title, forKey: "title")
        managedObj.setValue(comment, forKey: "comment")
        managedObj.setValue(location.coordinate.latitude, forKey: "latitude")
        managedObj.setValue(location.coordinate.longitude, forKey: "longitude")
        managedObj.setValue(location.altitude, forKey: "altitude")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /** Get all the location from our entity.
    - returns: A list of Location objects.
    */
    class func fetchObj() -> [Location]{
        var aray = [Location]()
        
        let fetchRequest:NSFetchRequest<Zones> = Zones.fetchRequest()
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            
            for item in fetchResult {
                let zones = Location(title: item.title!, comment: item.comment!, longitude: item.longitude, latitude: item.latitude, altitude: item.altitude)
                aray.append(zones)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        return aray
    }
    
    /**
        Clean a row from CoreData by it's name.
        - Parameter container: Title of the location to delete.
    */
    class func cleanCoreData(container:String) {
        
        let fetchRequest:NSFetchRequest<Zones> = Zones.fetchRequest()
        
        var predicate = NSPredicate(format: "title contains[c] %@", container)
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }

}
