//
//  ItinEventTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 12/12/20.
//

import UIKit

class ItinEventTableViewController: UITableViewController, UITextViewDelegate {
    
    var event: DayEvent!
    var isAnExistingEvent = true
    var eventNo: Int = 0
    let datePicker = UIDatePicker()
    var date: String = ""
    let formatter = DateFormatter()
    var dateArray: Array<Any> = []
    var creatingItemFromOverview: Bool = false
    var delegate: ItinDataDelegate?

    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var eventNoteView: UITextView!
    @IBOutlet weak var dateDatePicker: UIDatePicker!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        eventNoteView.backgroundColor = .init(red: 0, green: 0, blue: 1, alpha: 0.1)
        eventNoteView.text = ""
        formatter.dateFormat = "MM dd, yyyy"
        
        eventNoteView.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
        if event != nil{
            isAnExistingEvent = true
            destinationTextField.text = event.destination
            startTimeTextField.text = event.timeStart
            endTimeTextField.text = event.timeEnd
            eventNoteView.text = event.notes
            guard let datedate = formatter.date(from: event.date) else { return }
            dateDatePicker.setDate(datedate, animated: true)
        }else{
            print("event is not here!")
            isAnExistingEvent = false
            if creatingItemFromOverview == false{
            guard let defaultDate = formatter.date(from: dateArray[eventNo] as? String ?? "") else { return }
            print("dateArray:", dateArray, eventNo)
            dateDatePicker.setDate(defaultDate, animated: true)
            }
        }
        
        //trying to make textview dismissible
        eventNoteView.delegate = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "eventToEventsTable"{
                print("eventToEventsTable segue performed")
            }
        if segue.identifier == "unwindSave"{
            switch isAnExistingEvent {
            case true:
                if segue.destination is ItinEventsTableViewController{
                    event.destination = destinationTextField.text ?? ""
                    event.timeStart = startTimeTextField.text ?? ""
                    event.timeEnd = endTimeTextField.text ?? ""
                    event.notes = eventNoteView.text ?? "Notes!"
                    event.date = formatter.string(from: dateDatePicker.date)
                    print("event:",event as Any)
                        }
            default:
                event = DayEvent(destination:destinationTextField.text ?? "", timeStart: startTimeTextField.text ?? "", timeEnd: endTimeTextField.text ?? "", date: formatter.string(from: dateDatePicker.date), notes: eventNoteView.text ?? "Notes")
            }
            }
            
        }
    
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
*/
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func destinationEditingEnd(_ sender: Any) {
        destinationTextField.resignFirstResponder()
    }

    
    @IBAction func startTimeEditingEnd(_ sender: Any) {
        startTimeTextField.resignFirstResponder()
    }
    
    
    @IBAction func endTimeEditingEnd(_ sender: Any) {
        endTimeTextField.resignFirstResponder()
    }
    
   
    
    
    //trying to make the textview dismissible
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                eventNoteView.resignFirstResponder()
                return false
            }
            return true
        }

}


