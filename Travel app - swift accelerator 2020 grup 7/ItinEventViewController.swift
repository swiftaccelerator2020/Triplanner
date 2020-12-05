//
//  ItinEventViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 28/11/20.
//

import UIKit

class ItinEventViewController: UIViewController {
    
    var event: DayEvent!
    var isAnExistingEvent = true
    var eventNo: Int = 0

    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var eventNoteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNoteView.backgroundColor = .init(red: 0, green: 0, blue: 1, alpha: 0.1)
        eventNoteView.text = "Notes"

        // Do any additional setup after loading the view.
        if event != nil{
            isAnExistingEvent = true
            destinationTextField.text = event.destination
            startTimeTextField.text = event.timeStart
            endTimeTextField.text = event.timeEnd
            eventNoteView.text = event.notes
        }else{
            print("event is not here!")
            isAnExistingEvent = false
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backToOverviewViewController"{
            if let dest = segue.destination as? TripOverviewViewController{
                dest.itinOverviewLabel.text = event.destination
            }
        }
        
        
        if segue.identifier == "eventToEventsTable"{
                print("eventToEventsTable segue performed")
            }
        if segue.identifier == "unwindSave"{
            switch isAnExistingEvent {
            case true:
                if let dest = segue.destination as? ItinEventsTableViewController{
                    event.destination = destinationTextField.text ?? ""
                    event.timeStart = startTimeTextField.text ?? ""
                    event.timeEnd = endTimeTextField.text ?? ""
                    event.notes = eventNoteView.text ?? "Notes!"
                    print("event:",event)
                        }
            default:
                event = DayEvent(destination:destinationTextField.text ?? "", timeStart: startTimeTextField.text ?? "", timeEnd: endTimeTextField.text ?? "", date: "", notes: eventNoteView.text ?? "Notes")
            }
            }
            
        }

    
}
