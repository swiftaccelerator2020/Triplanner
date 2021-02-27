import UIKit

class BudgetTableViewController: UITableViewController {
    
    var spendingItemsArray: Array<BudgetItem> = []
    var spendingItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    var currentSpendingNo: Int = 0
    var viewTitle: String = "default"
    
    var storageSpendingItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    
    var trips: [Trip] = []
    var tripNo: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewTitle
        
        if let tempTrips = Trip.loadFromFile(){
            storageSpendingItemsDict = tempTrips[tripNo].budget
        }
        
        for (key,value) in storageSpendingItemsDict{
            let tempValue = value.sorted{
                $0.dateAndTime < $1.dateAndTime
            }
            storageSpendingItemsDict[key] = tempValue
        }
        
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
        let spendingItem = spendingItemsArray[indexPath.row]
        cell.textLabel?.text = "\(String(spendingItem.cost))"
        let tempFormatter = DateFormatter()
        tempFormatter.dateFormat = "dd MMM, HH:mm"
        cell.detailTextLabel?.text = "\(tempFormatter.string(from: spendingItem.dateAndTime)) | \(spendingItem.name)"
        
        
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
            storageSpendingItemsDict[self.title ?? "Other"]?.remove(at: indexPath.row)
            trips[tripNo].budget = storageSpendingItemsDict
            Trip.saveToFile(trips: trips)
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
            spendingItemsDict = storageSpendingItemsDict
        }
    }
    
    
    @IBAction func backToBudgetTableViewController(with segue: UIStoryboardSegue){
        
        if segue.identifier == "unwindSave"{
            if let source = segue.source as? AddSpendingViewController{
                if source.isExistingItem == true{
                    self.spendingItemsArray[currentSpendingNo] = source.budgetItem!
                    print("3 this is trying to change category:", self.spendingItemsArray)
                    
                    let current = spendingItemsArray[currentSpendingNo]
                    
                    if storageSpendingItemsDict.keys.contains(current.category) && storageSpendingItemsDict[current.category]?.isEmpty == false{
                    storageSpendingItemsDict[current.category]![currentSpendingNo] = current
                    }else{
                        storageSpendingItemsDict[current.category] = [current]
                    }
                    for (key,value) in storageSpendingItemsDict{
                        for i in value{
                            if i != current && i.name == current.name && i.cost==current.cost {
                                print("go to hell:", i)
                                storageSpendingItemsDict[key]?.remove(at: value.firstIndex(of: i)!)
                            }
                        }
                    }
                    
                    
                    print("if", storageSpendingItemsDict)
                    
                    
                }else{
                    self.spendingItemsArray.append(source.budgetItem!)
                    if storageSpendingItemsDict[source.budgetItem!.category] == nil{
                        let tempCat = source.budgetItem!.category
                        storageSpendingItemsDict[tempCat] = [source.budgetItem!]
                    }else{
                        storageSpendingItemsDict[source.budgetItem!.category]?.append(source.budgetItem!)
                    }
                }
                
                print("dateTimeTesting:", storageSpendingItemsDict)
                trips[tripNo].budget = storageSpendingItemsDict
                Trip.saveToFile(trips: trips)
                
            }
            tableView.reloadData()
        }
    }
}



