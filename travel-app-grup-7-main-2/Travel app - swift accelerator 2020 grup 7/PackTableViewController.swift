//
//  PackTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Apple April on 28/11/20.
//

import UIKit

class PackTableViewController: UITableViewController {

    var packingList = [Pack(item: "Clothes"),
                       Pack(item: "Toothbrush")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packingList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "packingList", for: indexPath)

        cell.textLabel?.text = packingList[indexPath.row].item
        if packingList[indexPath.row].done {
        cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self)
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
            packingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

   
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let pack = packingList.remove(at: fromIndexPath.row)
        packingList.insert(pack, at: to.row)
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
        
         if segue.identifier == "showDetail" {
         let nav = segue.destination as! UINavigationController
         let dest = nav.viewControllers.first as! EditPackTableViewController
            
            if let indexPathForSelectedRow = tableView.indexPathForSelectedRow {
            dest.pack = packingList[indexPathForSelectedRow.row]
            } else {
                dest.isNewPack = true
            }
         }

    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    @IBAction  func unwindToPack(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindFromDetail" {
            let source = segue.source as! EditPackTableViewController
            if source.isNewPack {
            packingList.append(source.pack)
            }
        }
    }
}
