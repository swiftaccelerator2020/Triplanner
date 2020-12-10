//
//  AddSpendingViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by nicole on 9/12/20.
//

import UIKit

class AddSpendingViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        categories.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        categories[row]
    }
    
    var budgetItem: BudgetItem?
    var isExistingItem: Bool = false
    var categories: Array<String> = ["Food", "Accomodation", "Shopping", "Travel", "Other"]
    
    @IBOutlet weak var spendingNameTextField: UITextField!
    @IBOutlet weak var spendingCostTextField: UITextField!
    @IBOutlet var spendingNotesTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    
    @IBAction func spendingNameTextfieldUpdated(_ sender: Any) {

    }
    @IBAction func spendingCostTextfieldUpdated(_ sender: Any) {
        
    }
    @IBOutlet var spendingNotesTextViewUpdated: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self

        if isExistingItem == true{
            spendingNameTextField.text = budgetItem?.name
            spendingCostTextField.text = "\(String(budgetItem?.cost ?? 0))"
//           "not now" = budgetItem?.category
            spendingNotesTextView.text = budgetItem?.notes
        }
    
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave"{
        if self.isExistingItem == true{
        self.budgetItem?.name = spendingNameTextField.text ?? ""
            self.budgetItem?.cost = Int(spendingCostTextField.text ?? "") ?? 0
            self.budgetItem?.category = "not now"
            self.budgetItem?.notes = spendingNotesTextView.text ?? ""
            
            print("existing:", self.budgetItem?.name)
            }else{
            self.budgetItem = BudgetItem(name: spendingNameTextField.text ?? "", cost: Int(spendingCostTextField.text ?? "") ?? 0, category: "not now", notes: spendingNotesTextView.text ?? "")
            
            print("new:", self.budgetItem?.name)
        }
    }
}

    
    

    @IBAction func enableAndDisablePickerView(_ sender: Any) {
    }
    
}
