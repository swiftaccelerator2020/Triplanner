//
//  BudgetCatTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 4/12/20.
//

import UIKit

class BudgetTableViewController: UITableViewController {
    
    var spendingItemsArray: Array<BudgetItem> = []
    var spendingItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    var currentSpendingNo: Int = 0
    var viewTitle: String = "default"
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewTitle
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return spendingItemsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "budgetCell", for: indexPath)
        cell.textLabel?.text = "\(String(spendingItemsArray[indexPath.row].cost))"
        cell.detailTextLabel?.text = spendingItemsArray[indexPath.row].name


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
            spendingItemsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? AddSpendingViewController{
                if segue.identifier == "showSpendingDetail"{
                    dest.budgetItem = self.spendingItemsArray[tableView.indexPathForSelectedRow!.row]
                    self.currentSpendingNo = tableView.indexPathForSelectedRow!.row
                    dest.isExistingItem = true
                }
                if segue.identifier == "catagoryAddNewSpending"{
                    dest.isExistingItem = false
                    
                }
            }
            
        }
        
        if segue.destination is BudgetViewController{
            for i in self.spendingItemsArray{
                if self.spendingItemsDict[i.category] == nil{
                    spendingItemsDict[i.category] = [i]
                }else{
                    spendingItemsDict[i.category]?.append(i)
                }
            }
            print("subview dict", spendingItemsDict)
        }
    }
    
    
    @IBAction func backToBudgetTableViewController(with segue: UIStoryboardSegue){
        
        if segue.identifier == "unwindSave"{
            if let source = segue.source as? AddSpendingViewController{
                if source.isExistingItem == true{
                    self.spendingItemsArray[currentSpendingNo] = source.budgetItem!
                    
                }else{
                    self.spendingItemsArray.append( source.budgetItem!)
                    print(spendingItemsArray)
                }
            }
            tableView.reloadData()
        }
    }
    }
    

