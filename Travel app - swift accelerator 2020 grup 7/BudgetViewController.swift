//
//  BudgetViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 29/11/20.
//

import UIKit

class BudgetViewController: UIViewController {

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
    var total: Int? = 0
    var spent: Int? = 0
    var left: Int? = 0
    var budgetItemsArray: Array<BudgetItem> = []
    var budgetItemsDict: Dictionary<String, Array<BudgetItem>> = [:]
    
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    
    
    // @IBOutlet weak var addSpendingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodButton.layer.cornerRadius = 25
        accomodationButton.layer.cornerRadius = 25
        shoppingButton.layer.cornerRadius = 25
        travelButton.layer.cornerRadius = 25
        otherButton.layer.cornerRadius = 25
        
    }
    
    
    @IBAction func screenTapped(_ sender: Any) {
        print("tapped")
        }
    
    
    
    
    @IBAction func totalBudgetEdited(_ sender: Any) {
//        editIndicator1 = true
//        total = Int(totalBudgetTextField.text ?? "0")
//        left = total ?? 0 - spent!
//        amountLeftTextField.text = String(left ?? 0)
        
    }
    
 




    //        editIndicator2 = true
//        spent = Int(amountSpentTextField.text ?? "0")
//        left = total ?? 0 - spent!
//        amountLeftTextField.text = String(left ?? 0)
        

    
    @IBAction func amountLeftEdited(_ sender: Any) {    
//        editIndicator3 = true
//        left = Int(amountLeftTextField.text ?? "0")
//        spent = total ?? 0 - left!
//        amountSpentTextField.text = String(spent ?? 0)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if budgetItemsDict.isEmpty == false{
            if let navigationVC = segue.destination as? UINavigationController{
                
            }
        }
//        if budgetItemsArray.isEmpty == false{
//        print("current array:", budgetItemsArray)
//        if let navigationVC = segue.destination as? UINavigationController{
//            var tempArray: Array<BudgetItem> = []
//            for i in ["foodSpending", "accomodationSpending", "shoppingSpending", "travelSpending", "otherSpending"]{
//                if segue.identifier! == i{
//                    for item in self.budgetItemsArray{
//                        if item.category.dropFirst(1) == i.dropFirst(1).dropLast(8){
//                            tempArray.append(item)
//                            if let dest = navigationVC.topViewController as? BudgetTableViewController{
//                                dest.spendingItemsArray = tempArray
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
    }
}
