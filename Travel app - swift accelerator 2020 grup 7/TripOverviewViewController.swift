import UIKit

protocol ItinDataDelegate {
    func printItinEvent(titleDict: Dictionary<Int, Any>)
}

protocol PackingListDataDelegate {
    func printPackingListItem(titleArray: Array<PackingItem>, isChecked: Bool)
}

protocol PackingListCheckedDelegate {
    func identify(isChecked: Bool)
}

protocol BudgetDataDelegate {
    func calculateBudget(string1: String, string2: String)
}

class TripOverviewViewController: UIViewController, ItinDataDelegate, PackingListDataDelegate, BudgetDataDelegate{
    
    func calculateBudget(string1: String, string2: String) {
        budgetOverviewLabel.text = "\(string1)\n\(string2)"
        print("delegate working")
    }
    
    
   
    
    fileprivate func packingListCircleChecking(_ item: PackingItem) {
        print("circle checking")
        packingListOverviewLabel.text = item.name
        packingListCheckCircle.isHidden = false
        for i in packingItemsStorateList{
            if i.name == packingListOverviewLabel.text{
                if i.checked{
                    print("circle checking 1")
                    packingListCheckCircle.setImage(UIImage(named: "checkmark.circle"), for: .normal)
                }else{
                    print("circle checking 2")
                    packingListCheckCircle.setImage(UIImage(named: "circle"), for: .normal)
                }
            }
        }
    }
    
    fileprivate func packingListCircleChecking2(_ item: PackingItem) {
        packingListOverviewLabel2.text = item.name
        packingListCheckCircle2.isHidden = false
        for i in packingItemsStorateList{
            if i.name == packingListOverviewLabel2.text{
                if i.checked{
                    packingListCheckCircle2.setImage(UIImage(named: "checkmark.circle"), for: .normal)
                }else{
                    packingListCheckCircle2.setImage(UIImage(named: "circle"), for: .normal)
                }
            }
        }
    }
    
    func printPackingListItem(titleArray: Array<PackingItem>, isChecked: Bool) {
        
//        var tempArray: Array<PackingItem> = []
//        let titleArray = PackingItem.loadFromFile()
//        print("data saving not working", titleArray)
//        for i in titleArray ?? []{
//            if i.checked == false{
//                tempArray.append(i)
//            }
//        }
//        print(tempArray)
//
//
//        if tempArray.count >= 1 {
//            packingListCircleChecking(tempArray.randomElement() ?? tempArray[0])
////MARK: I WONDER WHY? IS THAT HOW A DELEGATE WORKS
////            packingListCircleChecking2(tempArray[1])
//        }
//        if tempArray.isEmpty == false{
//            packingListCircleChecking(tempArray[0])
//        }else{
//            if (titleArray ?? []).isEmpty == true{
//                packingListOverviewLabel.text = "Packing List Preview!"
//            }else{
//                if packingItemsStorateList.isEmpty == false{
//                packingListCircleChecking(packingItemsStorateList.randomElement() ?? packingItemsStorateList[0])
//                }
//            }
//        }
        
        
//        if count == 1{
//            packingListOverviewLabel.text = tempTitleArray[0].name
//            packingListCheckCircle.setImage(UIImage(named: "circle"), for: .normal)
//        }
//
//        if count == 2{
//
//
//            packingListOverviewLabel.text = tempTitleArray[1].name
//
//            packingListCheckCircle.setImage(UIImage(named: "circle"), for: .normal)
//
//        }else if count == 0{
//            packingListOverviewLabel.text = titleArray.randomElement()?.name
//            packingListCheckCircle.setImage(UIImage(named: "checkmark.circle"), for: .normal)
//        }
        
        
        
//        packingItemsStorateList = titleArray ?? []
//        PackingItem.saveToFile(packingItems: titleArray ?? [])
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
    
    //MARK: general overview variables
    var start: String = ""
    var end: String = ""
    @IBOutlet weak var locationTextField: UITextField!
    var tripNo: Int = 0
    var trip: Trip!
    var newTrip: Bool = true
    var trips: Array<Trip> = []
    
  //MARK: Itinerary overview variables
    @IBOutlet weak var newItineraryItem: UIButton!
    @IBOutlet weak var itinOverviewLabel: UILabel!
    @IBOutlet weak var itinOverviewLabel2: UILabel!
    @IBOutlet weak var overviewStartDatePicker: UIDatePicker!
    @IBOutlet weak var overviewEndDatePicker: UIDatePicker!
    
    var itinOverviewText: String = "itinOverviewText"
    var itinEventsDict: Dictionary<String, Array<DayEvent>> = [:]
    var dateStorageList: Array<String> = ["start", "end"]
    
    
    //MARK: Packing list overview variables
    @IBOutlet weak var packingListOverviewLabel: UILabel!
    @IBOutlet weak var packingListCheckCircle: UIButton!
    
    @IBOutlet weak var packingListOverviewLabel2: UILabel!
    @IBOutlet weak var packingListCheckCircle2: UIButton!
    
    var packingItemsStorateList: Array<PackingItem> = []
    

//MARK: Budget overview variables
    var budgetItemsStorageDict: Dictionary<String, Array<BudgetItem>> = [:]
    var budgetTotal: Double = 0.0
    @IBOutlet weak var budgetOverviewLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        print("tripNo:", tripNo)
        super.viewDidLoad()
        packingListCheckCircle.isHidden = true
        packingListCheckCircle2.isHidden = true
        
        packingListOverviewLabel2.text = "..."
        packingListCheckCircle2.isEnabled = false
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        locationTextField.text = trip.destination //MARK: to be resolved just a bit later
        start = formatter.string(from: trip.startDate)
        end = formatter.string(from: trip.endDate)
        itinEventsDict = trip.itinerary
        budgetItemsStorageDict = trip.budget
        budgetTotal = trip.totalBudget
        packingItemsStorateList = trip.packingList
        overviewStartDatePicker.setDate(trip.startDate, animated: true)
        overviewEndDatePicker.setDate(trip.endDate, animated: true)
        PackingItem.saveToFile(packingItems: trip.packingList)
            
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("newest newest testing:", itinEventsDict)
//        DayEvent.saveToFile(dayEvents: itinEventsDict)
        
        trip = Trip(destination: locationTextField.text ?? "", startDate: overviewStartDatePicker.date, endDate: overviewEndDatePicker.date, itinerary: itinEventsDict, budget: budgetItemsStorageDict, totalBudget: self.budgetTotal, packingList: packingItemsStorateList)
        
        trips[tripNo] = trip
        Trip.saveToFile(trips: trips)
        
        //MARK: ***************************
        var tempArray: Array<PackingItem> = []
        let titleArray = PackingItem.loadFromFile()
        packingItemsStorateList = titleArray ?? []
        for i in titleArray ?? []{
            if i.checked == false{
                tempArray.append(i)
            }
        }
        print(tempArray)
        
        
        if tempArray.count >= 1 {
            packingListCircleChecking(tempArray.randomElement() ?? tempArray[0])
//MARK: I WONDER WHY? IS THAT HOW A DELEGATE WORKS
//            packingListCircleChecking2(tempArray[1])
        }
        if tempArray.isEmpty == false{
            packingListCircleChecking(tempArray[0])
        }else{
            if (titleArray ?? []).isEmpty == true{
                packingListOverviewLabel.text = "Packing List Preview!"
            }else{
                if packingItemsStorateList.isEmpty == false{
                packingListCircleChecking(packingItemsStorateList.randomElement() ?? packingItemsStorateList[0])
                }
            }
        }
        packingItemsStorateList = titleArray ?? []
        PackingItem.saveToFile(packingItems: titleArray ?? [])
        //MARK: *********************
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? ItinTableViewController{
                dest.delegate = self
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM dd, yyyy"
                self.start = formatter.string(from: overviewStartDatePicker.date)
                self.end = formatter.string(from: overviewEndDatePicker.date)
                dateStorageList[0] = start
                dateStorageList[1] = end
                dest.schedule = dateStorageList
                dest.itinEventsDict = self.itinEventsDict
                
                dest.trips = trips
                dest.tripNo = tripNo
                
                for (_,value) in itinEventsDict{
                for i in value{
                    if i.date != ""{
                    print("iiiii", i)
                    let interval = getDateInterval(startDate: start, date: i.date)
                        if ((dest.dayDictionary[interval]?.isEmpty) == nil){
                    dest.dayDictionary[interval] = [i]
                    print("vc.dayDictionary",dest.dayDictionary)
                    }else{
                        dest.dayDictionary[interval]?.append(i)
                        print("vc.dayDictionary else",dest.dayDictionary)
                    }
                }
            }
        }
            }
            
        }
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? ItinEventTableViewController{
            dest.creatingItemFromOverview = true
            
        }
        }
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? PackingListTableViewController{
                dest.delegate = self
                dest.packingItems = self.packingItemsStorateList
                dest.trips = self.trips
                dest.tripNo = self.tripNo
            }
        }
        
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? BudgetViewController{
                dest.budgetItemsDict = self.budgetItemsStorageDict
                dest.total = self.budgetTotal
                dest.delegate = self
                dest.trips = trips
                dest.tripNo = tripNo
            }
            
        }
        
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? HomeTableViewController{
                self.trip = Trip(destination: self.locationTextField.text ?? "", startDate: self.overviewStartDatePicker.date, endDate: self.overviewEndDatePicker.date, itinerary: self.itinEventsDict, budget: self.budgetItemsStorageDict, totalBudget: self.budgetTotal, packingList: self.packingItemsStorateList)
                if trips.count < tripNo{
                    trips.append(trip)
                    dest.trips = trips
                }else{
                    trips[tripNo] = trip
                    dest.trips = trips
                }
                print("dest.trips", dest.trips)
                Trip.saveToFile(trips: trips)
            }
        }
    }
    

    // MARK: - Navigation






        
    @IBAction func backToItinEventsTableViewController (with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventTableViewController{
            if segue.identifier == "unwindSave"{
            print("backToOverviewViewController segue result:", source.event)
                if itinEventsDict[source.event.date] == nil{
                    itinEventsDict[source.event.date] = [source.event]
               }else{
                itinEventsDict[source.event.date]?.append(source.event)
                }
                itinOverviewLabel.text = source.event.destination
            }
            print("newitinEvents:", itinEventsDict)
            DayEvent.saveToFile(dayEvents: itinEventsDict)
            
            trip = Trip(destination: locationTextField.text ?? "", startDate: overviewStartDatePicker.date, endDate: overviewEndDatePicker.date, itinerary: itinEventsDict, budget: budgetItemsStorageDict, totalBudget: self.budgetTotal, packingList: packingItemsStorateList)
            
            trips[tripNo] = trip
            Trip.saveToFile(trips: trips)
    }
}
    
    @IBAction func backToOverViewController(with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinTableViewController{

            for (key, value) in source.dayDictionary{
                if value.isEmpty == false{
//                    let isContained =  itinEventsDict.keys.contains(value[0].date)
                    self.itinEventsDict[value[0].date] = value
                }else{
                    
                    for i in source.dateArray{
                        print("Overview i, start:", i, self.start)
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "MMM dd, yyyy"
//                        let formatter2 = DateFormatter()
//                        formatter2.dateFormat = "MMM dd, yyyy"
//                        let start = formatter.date(from: self.start)
//                        let end = formatter.date(from: i)
//                        print("Overview startDate, end:", start, end)
                        
                        let intervalForDeleting = getDateInterval(startDate: self.start, date: end)
                        if intervalForDeleting == key{
                        self.itinEventsDict[i] = []
                            print("intervalForDeleting", intervalForDeleting)
                            //MARK: This is where the problem is. Should be date format!!
                        }
                        }
                    }
                }
            }
            print("list passed:", itinEventsDict)
        
        if let source = segue.source as? BudgetViewController{
            self.budgetItemsStorageDict = source.budgetItemsDict
            self.budgetTotal = source.total ?? 0
        }
        
    }
    
    func getDateInterval(startDate: String, date: String) -> Int{
        print("startDate, date:", startDate,date)
        
        //stimulator: startDate, date: Dec 18, 2020 Dec 19, 2020
        
        let formatter = DateFormatter()
        var interval = 0
        formatter.dateFormat = "MMM dd, yyyy"
        let dateStart = formatter.date(from: startDate)!
        let dateEndTemp = formatter.date(from: date)
        let dateEnd = dateEndTemp?.addingTimeInterval(TimeInterval(60 * 60 * 24))
        interval = Int( (dateEnd?.timeIntervalSince(dateStart))!/(24.0*60.0*60.0)) - 1
        print("interval:", interval)
        return interval
    }

    @IBAction func checkCircle1Tapped(_ sender: Any) {
        print("newest testing!", packingItemsStorateList)
        var count = -1
        for i in packingItemsStorateList{
            count += 1
            if packingListOverviewLabel.text == i.name{
                if i.checked{
                    packingItemsStorateList[count].checked = false
                    packingListCheckCircle.setImage(UIImage(named: "circle"), for: .normal)
                }else{
                    packingItemsStorateList[count].checked = true
                    packingListCheckCircle.setImage(UIImage(named: "checkmark.circle"), for: .normal)
                }
                
                
            }
        }
        PackingItem.saveToFile(packingItems: packingItemsStorateList)
    }
    
    
    
    @IBAction func checkCircle2Tapped(_ sender: Any) {
        var count = -1
        for i in packingItemsStorateList{
            if i.name == packingListOverviewLabel2.text{
                count += 1
                if i.checked{
                    packingItemsStorateList[count].checked = false
                    packingListCheckCircle2.setImage(UIImage(named: "circle"), for: .normal)
                }else{
                    packingItemsStorateList[count].checked = true
                    packingListCheckCircle2.setImage(UIImage(named: "checkmark.circle"), for: .normal)
                }
                
            }
            
            
        }
        packingListCheckCircle2.setImage(UIImage(named: "circle"), for: .normal)
    }
    
    class TextFieldWithReturn: UITextField, UITextFieldDelegate
    {

        required init?(coder aDecoder: NSCoder)
        {
            super.init(coder: aDecoder)
            self.delegate = self
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool
        {
            textField.resignFirstResponder()
            return true
        }

    }
    

    
    
    @IBAction func locationEditingEnd(_ sender: Any) {
        locationTextField.resignFirstResponder()
        trips[tripNo].destination = locationTextField.text ?? ""
        Trip.saveToFile(trips: trips)
    }
    
    
    
    @IBAction func startDatePickerChanged(_ sender: Any) {
        trips[tripNo].startDate = overviewStartDatePicker.date
        Trip.saveToFile(trips: trips)
    }
    
    
    
    @IBAction func endDatePickerChanged(_ sender: Any) {
        
        trips[tripNo].endDate = overviewEndDatePicker.date
        Trip.saveToFile(trips: trips)
    }
}
