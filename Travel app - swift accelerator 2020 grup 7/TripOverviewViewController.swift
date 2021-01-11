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
    }
    
    
    
    
    func printItinEvent(titleDict: Dictionary<Int, Any>) {
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
        
        
        let updateItineraryPreviewTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
        RunLoop.main.add(updateItineraryPreviewTimer, forMode: RunLoop.Mode.common)

    }
    
    @objc func sayHello()
    {
        print("this is itinPreviewUpdate")
        let upComing = findUpComing()
        if upComing != DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: ""){
            let tempText = "\(upComing.destination) | \(upComing.timeStart), \(upComing.date)"
            itinOverviewLabel.text = tempText
        }else{
            itinOverviewLabel.text = "You have no upcoming events!"
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("newest newest testing:", itinEventsDict)
        
        trip = Trip(destination: locationTextField.text ?? "", startDate: overviewStartDatePicker.date, endDate: overviewEndDatePicker.date, itinerary: itinEventsDict, budget: budgetItemsStorageDict, totalBudget: self.budgetTotal, packingList: packingItemsStorateList)
        
        trips[tripNo] = trip
        Trip.saveToFile(trips: trips)
        
        //MARK: packing list ***********************************************************
        
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
        
        //MARK: itinerary **************************************************************
        
        let upComing = findUpComing()
        if upComing != DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: ""){
        let tempText = "\(upComing.destination) | \(upComing.timeStart), \(upComing.date)"
            itinOverviewLabel.text = tempText
        }else{
            itinOverviewLabel.text = "You have no upcoming events!"
        }
        
        //MARK: budget *****************************************************************
        
        var spendingAddedUp: Double = 0.0
        for i in self.budgetItemsStorageDict.values{
            spendingAddedUp += Double(i.reduce(0,{x,y in x + y.cost}))
        }
        let string1 = "Spent $\(spendingAddedUp) of $\(self.budgetTotal), $\((self.budgetTotal) - (spendingAddedUp)) left"
        print("this is string1:", string1)
        
        var string2 = ""
        for (key,value) in self.budgetItemsStorageDict{
            let tempCategorizedSpending = Double(value.reduce(0, {x,y in x + y.cost}))
            let percentage = ((tempCategorizedSpending/spendingAddedUp) * 100)
            let rounded = round(percentage)
            let tempString = "\(rounded)% of spendings (\(key))\n"
            string2.append(tempString)
            print("this is string2:", string2)
        }
        self.budgetOverviewLabel.text = "\(string1)\n\(string2)"
        
        
        
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
                if var oldValue = itinEventsDict.updateValue([source.event], forKey: source.event.date){
                    oldValue.append(source.event)
                    itinEventsDict[source.event.date] = oldValue
                }else{
                    itinEventsDict[source.event.date] = [source.event]
                }
                
                let upComing = findUpComing()
                if upComing != DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: ""){
                    let tempText = "\(upComing.destination) | \(upComing.timeStart), \(upComing.date)"
                    itinOverviewLabel.text = tempText
                }else{
                    itinOverviewLabel.text = "You have no upcoming events!"
                }

                
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
                        let intervalForDeleting = getDateInterval(startDate: self.start, date: end)
                        if intervalForDeleting == key{
                            self.itinEventsDict[i] = []
                            print("intervalForDeleting", intervalForDeleting)
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
        
        let formatter = DateFormatter()
        var interval = 0
        formatter.dateFormat = "MMM dd, yyyy"
        let dateStart = formatter.date(from: startDate)!
        let dateEndTemp = formatter.date(from: date)
        let dateEnd = dateEndTemp?.addingTimeInterval(TimeInterval(60 * 60 * 24))
        interval = Int( (dateEnd?.timeIntervalSince(dateStart))!/(24.0*60.0*60.0)) - 1
        return interval
    }
    
    func findUpComing() -> DayEvent{
        var interv: Double? = 0.0
        var upComingEvent = DayEvent(destination: "", timeStart: "", timeEnd: "", date: "", notes: "")
        
        for (_,value) in self.itinEventsDict{
            for i in value{
                let tempFormatter = DateFormatter()
                tempFormatter.dateFormat = "MMM dd, yyyy, HH:mm"
                let tempStartTime = tempFormatter.date(from: "\(i.date), \(i.timeStart)")
                let tempInterval = tempStartTime?.timeIntervalSinceNow
                if tempStartTime ?? Date() >= Date(){
                    //
                    if interv == 0.0{
                        interv = tempInterval
                        upComingEvent = i
                    }else{
                        if tempInterval ?? 0.0 <= interv ?? 0.0 {
                            interv = tempInterval
                            upComingEvent = i
                        }
                    }
                }
            }
            
        }
        return upComingEvent
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
