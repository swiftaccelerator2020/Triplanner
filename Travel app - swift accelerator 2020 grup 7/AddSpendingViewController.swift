//
//  AddSpendingViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by nicole on 9/12/20.
//

import UIKit

class AddSpendingViewController: UITableViewController {
    var budgetItem: BudgetItem?
    var isExistingItem: Bool = false
    @IBOutlet weak var spendingNameTextField: UITextField!
    
    @IBOutlet weak var spendingCostTextField: UITextField!
    
    @IBOutlet weak var spendingCategoryTextField: UITextField!
    @IBOutlet var spendingNotesTextView: UITextView!
    
    @IBAction func spendingNameTextfieldUpdated(_ sender: Any) {
        
    }
    @IBAction func spendingCostTextfieldUpdated(_ sender: Any) {
        
    }
    @IBOutlet var spendingNotesTextViewUpdated: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isExistingItem == true{
            spendingNameTextField.text = budgetItem?.name
            spendingCostTextField.text = "\(String(budgetItem?.cost ?? 0))"
            spendingCategoryTextField.text = budgetItem?.category
            spendingNotesTextView.text = budgetItem?.notes
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave"{
        if self.isExistingItem == true{
        self.budgetItem?.name = spendingNameTextField.text ?? ""
            self.budgetItem?.cost = Int(spendingCostTextField.text ?? "") ?? 0
            self.budgetItem?.category = spendingCategoryTextField.text ?? ""
            self.budgetItem?.notes = spendingNotesTextView.text ?? ""
            
            print("existing:", self.budgetItem?.name)
            }else{
            self.budgetItem = BudgetItem(name: spendingNameTextField.text ?? "", cost: Int(spendingCostTextField.text ?? "") ?? 0, category: spendingCategoryTextField.text ?? "", notes: spendingNotesTextView.text ?? "")
            
            print("new:", self.budgetItem?.name)
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

}
