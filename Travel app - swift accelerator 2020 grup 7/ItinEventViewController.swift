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

    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var eventNoteView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if event != nil{
            isAnExistingEvent = true
            startTimeTextField.text = event.timeStart
            endTimeTextField.text = event.timeEnd
            eventNoteView.text = event.notes
        }else{
            print("event is not here!")
            isAnExistingEvent = false
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "eventToEventsTable"{
                print("eventToEventsTable segue performed")
            }
        if segue.identifier == "unwindSave"{
            switch isAnExistingEvent {
            case true:
                if let dest = segue.destination as? ItinEventsTableViewController{
                    event.timeStart = startTimeTextField.text ?? ""
                    event.timeEnd = endTimeTextField.text ?? ""
                    event.notes = eventNoteView.text ?? "Notes!"
                    print("event:",event)
                        }
            default:
                event = DayEvent(destination:"", timeStart: startTimeTextField.text ?? "", timeEnd: endTimeTextField.text ?? "", date: "", notes: eventNoteView.text ?? "Notes")
            }
            }
            
        }

    
}
