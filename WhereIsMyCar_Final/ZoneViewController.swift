//
//  ZoneViewController.swift
//  WhereIsMyCar_Final
//
//  Created by Salim on 16/01/2017.
//  Copyright © 2017 Salim. All rights reserved.
//

import UIKit

class ZoneViewController: UITableViewController {

    @IBOutlet var zoneTableView: UITableView!
    var location:[Location]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Zone"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        //Binding our cutom xib Controller
        self.zoneTableView.register(UINib(nibName: "ZoneViewCell", bundle: nil), forCellReuseIdentifier: "ZoneViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.location?.count)!
    }
    
    func initLocation(locations:[Location])  {
        self.location = [Location]()
        for location in locations {
            self.location?.append(location)         	}
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZoneViewCell", for: indexPath) as! ZoneViewCell
        cell.setTitle(title: (location?[indexPath.row].title)!)
        // Configure the cell...
        return cell
    }
    
    //Set the Details attributes from the selected row and send it to the Details view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsvc: DetailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsController") as! DetailsController
        detailsvc.setValues(latitude: (location?[indexPath.row].latitude)!, longitude: (location?[indexPath.row].longitude)!, titleZone: (location?[indexPath.row].title)!, comment: (location?[indexPath.row].comment)!, altitude: (location?[indexPath.row].altitude)!)
        self.show(detailsvc, sender: nil)
			
    }
 

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDataHandler.cleanCoreData(container : (self.location?[indexPath.row].title)!)
            self.location?.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
            zoneTableView.reloadData()

        } else if editingStyle == .insert {
        }    
    }

}
