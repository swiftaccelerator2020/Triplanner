//
//  BudgetViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 29/11/20.
//

import UIKit

class BudgetViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var foodButton: UIButton!
    @IBOutlet weak var accomodationButton: UIButton!
    @IBOutlet weak var shoppingButton: UIButton!
    @IBOutlet weak var travelButton: UIButton!
    @IBOutlet weak var otherButton: UIButton!
    
    @IBOutlet weak var totalBudgetTextField: UITextField!
    @IBOutlet weak var amountSpentTextField: UITextField!
    @IBOutlet weak var amountLeftTextField: UITextField!
    
    var total: Double? = 0.0
    var spent: Double? = 0.0
    var left: Double? = 0.0
    var budgetItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    let categories: Array<String> = ["Food", "Accomodation", "Shopping", "Travel", "Other"]
    var itemOutOfCategory: Bool = false
    var calculatingDict: Dictionary<String, Double> = [:]
    var spendingAddedUp = 0.0
    var delegate: BudgetDataDelegate?
    
    var trips: [Trip] = []
    var tripNo: Int = 0
    
    
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    
    // @IBOutlet weak var addSpendingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodButton.layer.cornerRadius = 25
        accomodationButton.layer.cornerRadius = 25
        shoppingButton.layer.cornerRadius = 25
        travelButton.layer.cornerRadius = 25
        otherButton.layer.cornerRadius = 25
        self.totalBudgetTextField.delegate = self
        self.amountSpentTextField.delegate = self
        self.amountLeftTextField.delegate = self
        
        self.totalBudgetTextField.text = String(total ?? 0.0)
        
        //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
        self.addDoneButtonOnKeyboard()
        self.totalBudgetTextField.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        spendingAddedUp = 0.0
        for i in categories{
            var tempCategorizedBudget = 0.0
            tempCategorizedBudget += generateCategorizedSpending(category: i)
            spendingAddedUp += tempCategorizedBudget
            calculatingDict[i] = tempCategorizedBudget
            
            print(spendingAddedUp)
            amountSpentTextField.text = String(spendingAddedUp)
            spent = spendingAddedUp
            amountLeftTextField.text = String(total! - spendingAddedUp)
        }
    }
    
    
    @IBAction func screenTapped(_ sender: Any) {
        print("tapped")
    }

    @IBAction func totalBudgetFinishedEditing(_ sender: Any) {
        print("total budget done editing")
        total = Double(totalBudgetTextField.text ?? "")
        print(total as Any)
        left = (total ?? 0.0) - spent!
        amountLeftTextField.text = String((total ?? 0.0) - (spent ?? 0.0))
    
        
        trips[tripNo].totalBudget = total ?? 0.0
        trips[tripNo].budget = budgetItemsDict
        Trip.saveToFile(trips: trips)
        print(total)
    }
    
    
    
    @IBAction func amountSpentFinishedEditing(_ sender: Any) {
    }
    
    
    
    @IBAction func amountLeftFinishedEditing(_ sender: Any) {
    }
    
    
    
    
    
    
    @IBAction func backToBudgetViewController(with segue: UIStoryboardSegue){
        print("segue.source", segue.source)
        if let source = segue.source as? BudgetTableViewController{
            if  source.spendingItemsDict.isEmpty == false{
                for (key,value) in source.spendingItemsDict{
                    self.budgetItemsDict[key] = value
                }
            }
        }
        print("received dict", budgetItemsDict)
        trips[tripNo].budget = budgetItemsDict
        Trip.saveToFile(trips: trips)
    }
    
    @IBAction func backToBudgetTableViewController(with segue: UIStoryboardSegue){
        if let source = segue.source as? AddSpendingViewController{
            if segue.identifier == "unwindSave"{
                var newlyCreatedItem = self.budgetItemsDict[source.budgetItem?.category ?? "Other"]
                if newlyCreatedItem != nil{
                    newlyCreatedItem?.append(source.budgetItem!)
                    self.budgetItemsDict[source.budgetItem?.category ?? "Other"] = newlyCreatedItem
                    print(self.budgetItemsDict)
                }else{
                    self.budgetItemsDict[source.budgetItem?.category ?? "Other"] = [source.budgetItem!]
                }
                
                print("newly created item", newlyCreatedItem)
                
            }
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let navigationVC = segue.destination as? UINavigationController{
            if let dest = navigationVC.topViewController as? BudgetTableViewController{
                
                dest.trips = trips
                dest.tripNo = tripNo
                
                let viewTitle = returnName(string: segue.identifier!)
                dest.viewTitle = viewTitle
                print("viewTitle", viewTitle)
                if budgetItemsDict.isEmpty == false{
                    for i in categories{
                        let name =  returnName(string: segue.identifier!)
                        if i == name{
                            dest.spendingItemsArray = self.budgetItemsDict[i] ?? []
                        }
                    }
                }
            }
        }
        
        
        
        if let dest = segue.destination as? TripOverviewViewController{
            if total != nil{
                //let string1 = "total budget $\(total!), spent $\(spendingAddedUp), \(spendingAddedUp/(total ?? 1.0)*100)% of total"
                let string1 = "spent $\(spendingAddedUp) of $\(total!), $\((total!) - (spendingAddedUp)) left"
//                var string2 = ""
//                for (key,value) in self.calculatingDict{
//                    let percentage = ((value/spendingAddedUp) * 100)
//                    let tempString = "\(round(percentage))% of spendings (\(key))\n"
//                    string2.append(tempString)
//                }
                //^old version that returns "NaN"
                
                var string2 = ""
                for (key,value) in self.calculatingDict{
                    let percentage = ((value/spendingAddedUp) * 100)
                    let rounded = round(percentage)
                    let tempString = "\(rounded.isNaN ? 0 : rounded)% of spendings (\(key))\n"
                    string2.append(tempString)
                }
                
                print("string1, string2", string1, string2)
                delegate?.calculateBudget(string1: string1, string2: string2)
                
            }
        }
    }
    
    
    
    func returnName(string: String) -> String{
        var result: String = ""
        switch string {
        case "foodSpending":
            result = "Food"
        case "shoppingSpending":
            result = "Shopping"
        case "accomodationSpending":
            result = "Accomodation"
        case "travelSpending":
            result = "Travel"
        default:
            result = "Other"
        }
        return result
        
    }
    
    func returnButtonName(string: String) -> UIButton{
        var result: UIButton!
        switch string {
        case "Food":
            result = foodButton
        case "Accomodation":
            result = accomodationButton
        case "Shopping":
            result = shoppingButton
        case "Travel":
            result = travelButton
        default:
            result = otherButton
        }
        return result
        
    }
    
    @IBAction func foodButtonPressed(_ sender: UIButton) {
        
    }
    
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
    
    
    func generateCategorizedSpending(category: String) -> Double{
        var categorizedSpending = 0.0
        if self.budgetItemsDict[category] != nil{
            var tSpending = 0.0
            for i in (self.budgetItemsDict[category]!){
                tSpending += Double(i.cost)
            }
            let randomChoice = self.budgetItemsDict[category]?.randomElement()
            
            let foodAttributedTitle = NSAttributedString(string: "\(category): $\(tSpending)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25, weight: UIFont.Weight(0.5))])
            
            returnButtonName(string: category).setAttributedTitle(foodAttributedTitle, for: .normal)
            returnButtonName(string: category).titleLabel?.font = UIFont(name: "System Bold", size: 30)
            foodButton.titleLabel?.textAlignment = .left
            categorizedSpending = tSpending
        }
        return categorizedSpending
    }
    
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.totalBudgetTextField.inputAccessoryView = doneToolbar
        
    }
    
    @objc func doneButtonAction()
    {
        self.totalBudgetTextField.resignFirstResponder()
    
}

}
