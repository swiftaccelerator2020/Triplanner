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
    let datePicker = UIDatePicker()

    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var eventNoteView: UITextView!
    @IBOutlet weak var dateTextField: UITextField!
    
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
        
        
        createDatePicker()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
    
    func createDatePicker(){
        //tool bar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        //bar button
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
        toolBar.setItems([doneButton], animated: true)
        
        //assign toolbar
        dateTextField.inputAccessoryView = toolBar
        
        //assign date picker
        dateTextField.inputView = datePicker
        
        //date picker mode
        datePicker.datePickerMode = .date
        dateTextField.textAlignment = .center
    }
    
    @objc func doneButtonPressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        dateTextField.text = formatter.string(from: datePicker.date)
        let str = formatter.string(from: datePicker.date)
        print("strstr:", str)
        
        self.view.endEditing(true)
        print("dateTextField.text:",dateTextField.text ?? "")
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "MM dd, yyyy"
        let date1 = formatter2.date(from: "Mar 20, 2020")!
        let date2 = formatter2.date(from: "Mar 27, 2020")!
        print(date2.timeIntervalSince(date1)/(24.0*60.0*60.0))
        
        
        
        
    }


    
}
