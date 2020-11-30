//
//  ItinTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 27/11/20.
//

import UIKit

class ItinEventsTableViewController: UITableViewController {
    var dayNo = 0
    var events: Array<DayEvent> = []
    var eventItemNo = 0

    override func viewDidLoad() {
        self.title = "Events"
        super.viewDidLoad()
        print("ItinEventsTableViewController events: ", events)
//        if let loadedEvents = DayEvent.loadFromFile(){
//            print("File founded. Loading dayEvents.")
//            events = loadedEvents
//        }else{
//            print("No friends! Make some.")
//            events = DayEvent.loadSampleData()
//            print("events:", events)
//
//        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itinEventCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row].destination
        cell.detailTextLabel?.text = events[indexPath.row].timeStart

        // Configure the cell...
//        cell.textLabel?.text = (events[indexPath.row] as AnyObject).destination

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventItemNo = indexPath.row
        print("eventItemNo:", eventItemNo)
        
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
            events.remove(at: indexPath.row)
//MARK: ************How to save data to files
            DayEvent.saveToFile(dayEvents: events)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }



    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let tempEvent = events.remove(at: fromIndexPath.row)
        events.insert(tempEvent, at: to.row)
        tableView.reloadData()

    }

/*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToItinEventsTableViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        //from ItinEventViewController to ItinEventsTableViewController
    }
    
    @IBAction func cancel(unwindSegue: UIStoryboardSegue){
    }
    
    @IBAction func backToEventsTableViewController (with segue: UIStoryboardSegue){
        if segue.identifier == "unwindSave",
            let source = segue.source as? ItinEditTableViewController{
            if source.isAnExistingEvent == true{
            events.append(source.event)
            print("ItinEventsTableViewController events loaded: ", events)
                tableView.reloadData()}
            if source.isAnExistingEvent == false{
                tableView.reloadData()
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventsToEventDetail"{
            print("eventsToEventDetail segue working")
            if let dest = segue.destination as? ItinEventViewController{
            dest.event = events[eventItemNo]
                print("event!:", dest.event ?? "error")
            }
        }
        
            if let dest = segue.destination as? ItinTableViewController{
                print("ItinEventsTableViewController events about to pass: ", events)
                dest.daysDictionary[dayNo] = events
                print("unwindToItinTableViewController segue performed")
        }
    }

}
