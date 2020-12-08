//
//  PackingListTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 28/11/20.
//

import UIKit

class PackingListTableViewController: UITableViewController {

   
    
    var PackingItem = [
        packingItem(name: "Add in the things you wish to pack!")
    ]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PackingItem.count 
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "packingListItem", for: indexPath) as! PackingListTableViewCell
        
        cell.textLabel?.text = PackingItem[indexPath.row].name
        
        /*if PackingItem[indexPath.row].done {
        cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }*/
        //cell.accessoryType = PackingItem[indexPath.row].done ? .checkmark : .none

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
            // Delete the row from the data source
            PackingItem.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let packingitem = PackingItem.remove(at: fromIndexPath.row)
        PackingItem.insert(packingitem, at: to.row)
        tableView.reloadData()
    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.viewControllers.first as! EditPackingItemTableViewController
            
            if tableView.indexPathForSelectedRow != nil {
            dest.PackingItem = PackingItem[tableView.indexPathForSelectedRow!.row]
            } else {
                dest.newPackingItem = true
            }
        
    }
    
}
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    @IBAction func unwindToPackingItems(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindFromDetail" {
            let source = segue.source as! EditPackingItemTableViewController
            if source.newPackingItem {
                PackingItem.append(source.PackingItem)
            }
        }

      
    }
    
}
