//
//  ItinEditTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 29/11/20.
//

import UIKit

class ItinEditTableViewController: UITableViewController {
    var event: DayEvent!
    var isAnExistingEvent = true
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if event != nil{
            destinationTextField.text = event.destination
            startTimeTextField.text = event.timeStart
            endTimeTextField.text = event.timeEnd
            dateTextField.text = event.date
        }

  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave"{
            let destination = destinationTextField.text
            let startTime = startTimeTextField.text
            let endTime = endTimeTextField.text
            let date = dateTextField.text
            if event == nil{
                event = DayEvent(destination: destination ?? "", timeStart: startTime ?? "", timeEnd: endTime ?? "", date: date ?? "", notes: "")
            }else{
                event.destination = destination ?? ""
                event.timeStart = startTime ?? ""
                event.timeEnd = endTime ?? ""
                event.date = date ?? ""
            }
            
            
        }
    }

}
