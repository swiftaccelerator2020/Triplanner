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
    var editIndicator1: Bool = false
    var editIndicator2: Bool = false
    var editIndicator3: Bool = false
    var total: Float? = 0.0
    var spent: Float? = 0.0
    var left: Float? = 0.0
    var budgetItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    let categories: Array<String> = ["Food", "Accomodation", "Shopping", "Travel", "Other"]
    var itemOutOfCategory: Bool = false
    var calculatingDict: Dictionary<String, Int> = [:]
    
    
    
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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if self.budgetItemsDict["Food"] != nil{
            let foodAttributedTitle = NSAttributedString(string: "Food spending: \n \(self.budgetItemsDict["Food"]![0].name): \(self.budgetItemsDict["Food"]![0].cost)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        foodButton.setAttributedTitle(foodAttributedTitle, for: .normal)
        foodButton.titleLabel?.font = UIFont(name: "system", size: 2)
            foodButton.titleLabel?.textAlignment = .left
        }

        print("foodButton.titleLabel",foodButton.titleLabel)
        
//        for (key,value) in budgetItemsDict{
//            print(budgetItemsDict)
//            foodButton.setTitle("My food", for: .normal)
//
//
//        }
    }
    
    
    @IBAction func screenTapped(_ sender: Any) {
        print("tapped")
        }
    
    
    
    
 

//MARK: Logic to be cleared later
    @IBAction func totalBudgetFinishedEditing(_ sender: Any) {
        print("total budget done editing")
        total = Float(totalBudgetTextField.text ?? "")
        if total == nil{
            totalBudgetTextField.text = "0.0"
        }else{
            if amountLeftTextField.text != ""{
            left = total ?? 0.0 - (spent ?? 0.0)
            amountLeftTextField.text = String(left!)
            }
        }
    }
    
    
    
    @IBAction func amountSpentFinishedEditing(_ sender: Any) {
         spent =  Float(amountSpentTextField.text ?? "")
        if spent == nil{

        }else{
            left = total ?? 0.0 - (spent ?? 0.0)
            print("left:",left)
            amountLeftTextField.text = String(left!)
        }
        
    }
    
    

    @IBAction func amountLeftFinishedEditing(_ sender: Any) {
        print("amountLeftFinishedEditing")
        left = Float(amountLeftTextField.text ?? "")
        if left == nil{

        }else{
            spent = total ?? 0.0 - (left ?? 0.0)
            amountSpentTextField.text = String(spent!)
        }
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
    
    @IBAction func foodButtonPressed(_ sender: UIButton) {
        
    }
    
//    @IBAction func totalBudgetEditingEnd(_ sender: Any) {
//        totalBudgetTextField.resignFirstResponder()
//    }
//
//
//    @IBAction func amountSpentEditingEnd(_ sender: Any) {
//        amountSpentTextField.resignFirstResponder()
//    }
//
//
//    @IBAction func amountLeftEditingEnd(_ sender: Any) {
//        amountLeftTextField.resignFirstResponder()
//    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        self.view.endEditing(true)
        return false
    }
}
