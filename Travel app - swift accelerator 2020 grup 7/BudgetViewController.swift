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
        print(total)
        left = (total! - spent!)
        amountLeftTextField.text = String(total! - spent!)
//        if total == nil{
//            totalBudgetTextField.text = "0.0"
//        }else{
//            if amountLeftTextField.text != ""{
//            left = total ?? 0.0 - (spent ?? 0.0)
//            amountLeftTextField.text = String(left!)
//            }
//        }
    }
    
    
    
    @IBAction func amountSpentFinishedEditing(_ sender: Any) {
//         spent =  Double(amountSpentTextField.text ?? "")
//        if spent == nil{
//
//        }else{
//            left = total ?? 0.0 - (spent ?? 0.0)
//            print("left:",left)
//            amountLeftTextField.text = String(left!)
//        }
        
    }
    
    

    @IBAction func amountLeftFinishedEditing(_ sender: Any) {
//        print("amountLeftFinishedEditing")
//        left = Double(amountLeftTextField.text ?? "")
//        if left == nil{
//
//        }else{
//            spent = total ?? 0.0 - (left ?? 0.0)
//            amountSpentTextField.text = String(spent!)
//        }
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
        print("received dict", self.budgetItemsDict)
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
            let string1 = "total budget $\(total!), spent $\(spendingAddedUp), \(spendingAddedUp/(total ?? 1.0)*100)% of total"
            //MARK: the percentage needs rounding up
            
            var string2 = ""
            for (key,value) in self.calculatingDict{
                let percentage = (value/total!) * 100
                let tempString = "\(percentage)% of total   $\(value)  \(key) spent\n"
                string2.append(tempString)
            }
            //MARK: the percentage here needs rounding up too
            
            print("string1, string2", string1, string2)
            delegate?.calculateBudget(string1: string1, string2: string2)
            
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
            
            let foodAttributedTitle = NSAttributedString(string: "\(category): $\(tSpending)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
//            \n\(randomChoice!.name): $\(randomChoice!.cost)"
            
        returnButtonName(string: category).setAttributedTitle(foodAttributedTitle, for: .normal)
        returnButtonName(string: category).titleLabel?.font = UIFont(name: "system", size: 4)
            foodButton.titleLabel?.textAlignment = .left
            categorizedSpending = tSpending
        }
        return categorizedSpending
    }
}


