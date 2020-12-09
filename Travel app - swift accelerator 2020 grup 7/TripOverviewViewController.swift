//
//  TripOverviewViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 4/12/20.
//

import UIKit

protocol ItinDataDelegate {
    func printItinEvent(titleDict: Dictionary<Int, Any>)
}

protocol PackingListDataDelegate {
    func printPackingListItem(titleArray: Array<packingItem>, checked: Bool)
}

protocol PackingListCheckedDelegate {
    func identify(isChecked: Bool)
}

class TripOverviewViewController: UIViewController, ItinDataDelegate, PackingListDataDelegate, PackingListCheckedDelegate {
    
    func identify(isChecked: Bool) {
        if isChecked{
            self.packingListCheckCircle.isHidden = false
        }else{
            self.packingListCheckCircle.isHidden = true
        }
    }
    
    func printPackingListItem(titleArray: Array<packingItem>, checked: Bool) {
        print("delegate titleArray:", titleArray)
        packingListOverviewLabel.text = (titleArray[0]).name
//        if checked{
//            packingListCheckCircle.isHidden = false
//        }else{
//            packingListCheckCircle.isHidden = true
//        }
    }
    
    func printItinEvent(titleDict: Dictionary<Int, Any>) {
        print("delegate titleDict:", titleDict)
        for (_, value) in titleDict{
            print("value", value)
            if (value as! Array<DayEvent>).isEmpty == false{
            switch (value as! Array<DayEvent>)[0] {
            case nil:
                itinOverviewLabel.text = "You have no trip at the moment! Create some"
                itinOverviewLabel2.text = ""
            default:
                itinOverviewLabel.text = (value as!Array<DayEvent>)[0].destination
            }
        }
    }
    }
  //MARK: Itinerary overview variables
    @IBOutlet weak var newItineraryItem: UIButton!
    @IBOutlet weak var itinOverviewLabel: UILabel!
    @IBOutlet weak var itinOverviewLabel2: UILabel!
    @IBOutlet weak var overviewStartDatePicker: UIDatePicker!
    @IBOutlet weak var overviewEndDatePicker: UIDatePicker!
    
    var itinOverviewText: String = "itinOverviewText"
    var storedItinEvents: Array<DayEvent> = []
    var dateStorageList: Array<String> = ["start", "end"]
    
    
    //MARK: Packing list overview variables
    @IBOutlet weak var packingListOverviewLabel: UILabel!
    @IBOutlet weak var packingListCheckCircle: UIButton!
    var storedPackingItems: Array<packingItem> = []
    
    
    

//MARK: Budget overview variables
    
    override func viewDidLoad() {
        super.viewDidLoad()
        packingListCheckCircle.isHidden = true
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

                for i in storedItinEvents{
                    if i.date != ""{
                    print("iiiii", i)
                    let interval = getDateInterval(startDate: start, date: i.date)
                        if ((vc.dayDictionary[interval]?.isEmpty) == nil){
                    vc.dayDictionary[interval] = [i]
                    print("vc.dayDictionary",vc.dayDictionary)
                    }else{
                        vc.dayDictionary[interval]?.append(i)
                        print("vc.dayDictionary else",vc.dayDictionary)
                    }
                }
            }
        }
            
        }
        if let dest = segue.destination as? ItinEventViewController{
            dest.creatingItemFromOverview = true
            
        }
        if let navigationVC2 = segue.destination as? UINavigationController{
            if let vc = navigationVC2.topViewController as? PackingListTableViewController{
                vc.delegate = self
            }
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


        
    @IBAction func backToItinEventsTableViewController (with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventViewController{
            if segue.identifier == "unwindSave"{
            print("backToOverviewViewController segue result:", source.event)
            storedItinEvents.append(source.event)
                itinOverviewLabel.text = source.event.destination
            }
            print("newitinEvents:", storedItinEvents)
    }
}
    
    @IBAction func backToOverViewController(with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinTableViewController{
            for (_, value) in source.dayDictionary{
                for i in value{
                   let isContained =  storedItinEvents.contains(i)
                    if isContained == true{
                        //
                    }else{
                        storedItinEvents.append(i)
                    }
                }
            }
            print("list passed:", storedItinEvents)
        }
        
    }
    
    func getDateInterval(startDate: String, date: String) -> Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM dd, yyyy"
        let dateStart = formatter.date(from: startDate)!
        let dateEndTemp = formatter.date(from: date)!
        let dateEnd = dateEndTemp.addingTimeInterval(TimeInterval(60 * 60 * 24))
        let interval = Int( dateEnd.timeIntervalSince(dateStart)/(24.0*60.0*60.0)) - 1
        print("interval:", interval)
        return interval
    }


}
