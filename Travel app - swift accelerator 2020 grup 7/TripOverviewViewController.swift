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
  //MARK: Itinerary overview variables
    @IBOutlet weak var newItineraryItem: UIButton!
    @IBOutlet weak var itinOverviewLabel: UILabel!
    @IBOutlet weak var itinOverviewLabel2: UILabel!
    @IBOutlet weak var overviewStartDatePicker: UIDatePicker!
    @IBOutlet weak var overviewEndDatePicker: UIDatePicker!
    

    var itinOverviewText: String = "itinOverviewText"
    var newlyCreatedEvent: DayEvent? = nil
    var newItinEvents: Array<DayEvent> = []
    var dateStorageList: Array<String> = ["start", "end"]
    
    
//MARK: Packing list overview variables
//MARK: Budget overview variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if itinEvents .isEmpty == false{
//            itinOverviewLabel.text = itinEvents[0].destination
//        }
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

                for i in newItinEvents{
//                    if ((vc.dayDictionary[0]?.isEmpty == false)){
//                        vc.dayDictionary[0]?.append(i)
//                    }else{
//                        vc.dayDictionary[0]
//                    }
                    vc.dayDictionary[0] = [i]
                    print("vc.dayDictionary",vc.dayDictionary,i)
                }
            }
            
        }
        if let dest = segue.destination as? ItinEventViewController{
            dest.creatingItemFromOverview = true
            
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
            if segue.identifier == "unwindSave"{
            print("backToOverviewViewController segue result:", source.event)
            newItinEvents.append(source.event)
            }
//            switch source.event {
//            case nil:
//                print("source.event is nil")
//            default:
//                newlyCreatedEvent = source.event
//            }
//            if newItinEvents.isEmpty != true{
//                itinOverviewLabel.text = "\(newItinEvents[0].destination),\(newItinEvents[0].date)"
//            }
            print("itinEvents:", newItinEvents)
    }
}
    
    @IBAction func backToOverViewController(with segue: UIStoryboardSegue){
        
    }


}
