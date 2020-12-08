//
//  TripOverviewViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 4/12/20.
//

import UIKit

protocol DataDelegate {
    func printTextOnButton(titleDict: Dictionary<Int, Any>)
}

class TripOverviewViewController: UIViewController, DataDelegate {
    func printTextOnButton(titleDict: Dictionary<Int, Any>) {
        print("working")
        print("titleDict:", titleDict)
       itinOverviewLabel.text = "replace with titledict string"
    }
    
    @IBOutlet weak var ItinButtonOutlet: UIButton!
    @IBOutlet weak var itinOverviewLabel: UILabel!
    @IBOutlet weak var overviewStartDatePicker: UIDatePicker!
    @IBOutlet weak var overviewEndDatePicker: UIDatePicker!
    

    var itinOverviewText: String = "itinOverviewText"
    var newlyCreatedEvent: DayEvent? = nil
    var itinEvents: Array<DayEvent> = []
    var dateStorageList: Array<String> = ["start", "end"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if itinEvents .isEmpty == false{
            itinOverviewLabel.text = itinEvents[0].destination
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let vc = navigationVC.topViewController as? ItinTableViewController{
        vc.delegate = self
                let formatter = DateFormatter()
                formatter.dateFormat = "MM dd, yyyy"
                let start = formatter.string(from: overviewStartDatePicker.date)
                let end = formatter.string(from: overviewEndDatePicker.date)
                dateStorageList[0] = start
                dateStorageList[1] = end
                vc.schedule = dateStorageList
            }
            
        }
//        for i in dayDictionary{
//            print("i.value:", i.value[0].destination, i.value[0].date)
//            itinOverviewList.append( "\(i.value[0].destination), \(i.value[0].date)")
//
//        }
        
        if let dest = segue.destination as? ItinEventViewController{
            
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

    @IBAction func itinButton(_ sender: Any) {
    }
        
    @IBAction func backToItinEventsTableViewController (with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventViewController{
            print("backToOverviewViewController segue result:", source.event)
            switch source.event {
            case nil:
                print("source.event is nil")
            default:
                newlyCreatedEvent = source.event
            }
            if itinEvents.isEmpty != true{
                itinOverviewLabel.text = "\(itinEvents[0].destination),\(itinEvents[0].date)"
            }
            print("itinEvents:", itinEvents)
    }
}
    
    @IBAction func backToOverViewController(with segue: UIStoryboardSegue){
        
    }


}
