import UIKit

class PackingListTableViewController: UITableViewController {
    var delegate: PackingListDataDelegate?
    var isChecked: Bool = false
    
    var trips: [Trip] = []
    var tripNo: Int = 0

   
    
    var packingItems = [
        PackingItem(name: "Add in the things you wish to pack!", checked: false, note: "")
    ]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadedPackingItems = PackingItem.loadFromFile(){
            packingItems = loadedPackingItems
            print("File founded. Loading packingItems.")
        }else{
            print("No packingItems! Make some.")
            packingItems = []
        }
        
        packingItems = packingItems.sorted{
            (!$0.checked && $1.checked)
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        PackingItem.saveToFile(packingItems: packingItems)
        trips[tripNo].packingList = packingItems
        Trip.saveToFile(trips: trips)
        print(trips)
    }
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.printPackingListItem(titleArray: packingItems, isChecked: isChecked)
        print("what is checked", isChecked)
        PackingItem.saveToFile(packingItems: packingItems)
    }

       // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return packingItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "packingListItem", for: indexPath) as! PackingListTableViewCell
        cell.PackingListvc = self
        cell.textLabel?.text = packingItems[indexPath.row].name
        if packingItems[indexPath.row].checked{
            cell.circleButton.setImage(UIImage(named: "checkmark.circle"), for: .normal)
        }else{
            cell.circleButton.setImage(UIImage(named: "circle"), for: .normal)
        }
       
        
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
            packingItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let packingitem = packingItems.remove(at: fromIndexPath.row)
        packingItems.insert(packingitem, at: to.row)
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
            dest.packingItem = packingItems[tableView.indexPathForSelectedRow!.row]
            } else {
                dest.newPackingItem = true
            }
        
    }
    
}
    
    @IBAction func plusButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "showDetail", sender: self)
        
        let alert = UIAlertController(title: "Hello", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: {UITextField in UITextField.placeholder = "New item to pack:"})
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: {action in
            
            if let PackingListAlertItem = alert.textFields?.first?.text {
                print("new item: \(PackingListAlertItem)")
            }
        }))
        
        self.present(alert, animated: true)
    }
     
    @IBAction func unwindToPackingItems(segue: UIStoryboardSegue) {
        if segue.identifier == "unwindFromDetail" {
            let source = segue.source as! EditPackingItemTableViewController
            if source.newPackingItem {
                packingItems.append(source.packingItem)
                PackingItem.saveToFile(packingItems: packingItems)
            }else{
                packingItems[tableView.indexPathForSelectedRow!.row] = source.packingItem
                PackingItem.saveToFile(packingItems: packingItems)
            }
        }

      
    }
    
}
