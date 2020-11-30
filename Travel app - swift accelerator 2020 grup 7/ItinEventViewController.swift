//
//  ItinEventViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 28/11/20.
//

import UIKit

class ItinEventViewController: UIViewController {
    
    var event: DayEvent!

    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var eventNoteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if event != nil{
            startTimeTextField.text = event.timeStart
            endTimeTextField.text = event.timeEnd
            eventNoteView.text = event.notes
        }else{
            print("event is not here!")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventToEditViewController"{
            if let dest = segue.destination as? ItinEditTableViewController{
            dest.event = event
            }
            
        }
//        if segue.identifier == "unwindToItinEventsTableViewController"{
//            if let dest = segue.destination as? ItinEventsTableViewController{
//                dest.daysDictionary[event.date] = event
//            }
//        }
    }
    
    
    

    @IBAction func saveButtonPressed(_ sender: Any) {
        event.notes = eventNoteView.text
        print(eventNoteView.text)
        
    }


    
}
