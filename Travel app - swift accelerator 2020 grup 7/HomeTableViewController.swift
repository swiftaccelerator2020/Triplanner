//
//  HomeTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 11/12/20.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var trips: Array<Trip> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if trips.isEmpty == true{
            return 0
        }else{return trips.count}
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if trips.isEmpty == false{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/mm/yyyy"
        cell.textLabel?.text = trips[indexPath.row].destination
            let sDate = formatter.string(from: trips[indexPath.row].startDate)
            let eDate = formatter.string(from: trips[indexPath.row].endDate)
        cell.detailTextLabel?.text = "\(sDate) - \(eDate)"
        }

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? TripOverviewViewController{
                if self.trips.isEmpty == false{
                dest.tripNo = tableView.indexPathForSelectedRow!.row
                dest.trip = trips[tableView.indexPathForSelectedRow!.row]
                    dest.generalTripsStorageList = trips
                }
            }
        }
    }
    
    @IBAction func backFromNewTrip(for segue: UIStoryboardSegue){
        if let source = segue.source as? NewTripTableViewController{
            trips.append(source.trip)
            print("backFromNewTrip", trips)
            tableView.reloadData()
        }
        
    }
    
    

}
