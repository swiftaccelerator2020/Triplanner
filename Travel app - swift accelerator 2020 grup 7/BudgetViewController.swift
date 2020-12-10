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
    var amountStorage: Dictionary<String, Int> = [:]
    
    
    
    // @IBOutlet weak var addSpendingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodButton.layer.cornerRadius = 25
        accomodationButton.layer.cornerRadius = 25
        shoppingButton.layer.cornerRadius = 25
        travelButton.layer.cornerRadius = 25
        otherButton.layer.cornerRadius = 25
        
    }
    @IBAction func totalBudgetEdited(_ sender: Any) {
//        editIndicator1 = true
//        total = Int(totalBudgetTextField.text ?? "0")
//        left = total ?? 0 - spent!
//        amountLeftTextField.text = String(left ?? 0)
        
    }
    
    @IBAction func amountSpentEdited(_ sender: Any) {
//        editIndicator2 = true
//        spent = Int(amountSpentTextField.text ?? "0")
//        left = total ?? 0 - spent!
//        amountLeftTextField.text = String(left ?? 0)
        
    }
    
    @IBAction func amountLeftEdited(_ sender: Any) {    
//        editIndicator3 = true
//        left = Int(amountLeftTextField.text ?? "0")
//        spent = total ?? 0 - left!
//        amountSpentTextField.text = String(spent ?? 0)
    }
    

}
