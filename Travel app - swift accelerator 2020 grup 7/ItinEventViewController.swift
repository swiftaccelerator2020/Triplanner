//
//  ItinEventViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 28/11/20.
//

import UIKit

class ItinEventViewController: UIViewController, UITextViewDelegate {
    
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
    
//    func createDatePicker(){
//        //tool bar
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//
//        //bar button
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        toolBar.setItems([doneButton], animated: true)
//
//        //assign toolbar
//        dateTextField.inputAccessoryView = toolBar
//
//        //assign date picker
//        dateTextField.inputView = datePicker
//
//        //date picker mode
//        datePicker.datePickerMode = .date
//        dateTextField.textAlignment = .center
//    }
    
//    @objc func doneButtonPressed(){
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium
//        formatter.timeStyle = .none
//
//        dateTextField.text = formatter.string(from: datePicker.date)
//        let str = formatter.string(from: datePicker.date)
//        print("strstr:", str)
//
//        self.view.endEditing(true)
//        print("dateTextField.text:",dateTextField.text ?? "")
//
//        let formatter2 = DateFormatter()
//        formatter2.dateFormat = "MM dd, yyyy"
//        let date1 = formatter2.date(from: "Mar 20, 2020")!
//        let date2 = formatter2.date(from: "Mar 27, 2020")!
//        print(date2.timeIntervalSince(date1)/(24.0*60.0*60.0))
//
//
//
//
//    }


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
