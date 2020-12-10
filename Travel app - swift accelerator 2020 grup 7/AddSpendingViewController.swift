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
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryLabel.text = categories[row]
    }
    
    var budgetItem: BudgetItem?
    var isExistingItem: Bool = false
    var categories: Array<String> = ["Food", "Accomodation", "Shopping", "Travel", "Other"]
    var setToPickerView: Bool = false
    
    @IBOutlet weak var spendingNameTextField: UITextField!
    @IBOutlet weak var spendingCostTextField: UITextField!
    @IBOutlet var spendingNotesTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryPickerView: UIPickerView!
    @IBOutlet weak var categoryPickerViewButton: UIButton!
    
    
    @IBAction func spendingNameTextfieldUpdated(_ sender: Any) {

    }
    @IBAction func spendingCostTextfieldUpdated(_ sender: Any) {
        
    }
    @IBOutlet var spendingNotesTextViewUpdated: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        self.categoryPickerView.isHidden = true

        if isExistingItem == true{
            spendingNameTextField.text = budgetItem?.name
            spendingCostTextField.text = "\(String(budgetItem?.cost ?? 0))"
            categoryLabel.text = budgetItem?.category
            spendingNotesTextView.text = budgetItem?.notes
        }else{
            categoryLabel.text = "Food"
        }
    
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave"{
        if self.isExistingItem == true{
        self.budgetItem?.name = spendingNameTextField.text ?? ""
            self.budgetItem?.cost = Int(spendingCostTextField.text ?? "") ?? 0
            self.budgetItem?.category = categoryLabel.text ?? "Other"
            self.budgetItem?.notes = spendingNotesTextView.text ?? ""
            
            }else{
                self.budgetItem = BudgetItem(name: spendingNameTextField.text ?? "", cost: Int(spendingCostTextField.text ?? "") ?? 0, notes: spendingNotesTextView.text ?? "", category: categoryLabel.text ?? "Other")
            
        }
    }
}

    
    

    @IBAction func enableAndDisablePickerView(_ sender: Any) {
        setToPickerView.toggle()
        switch categoryPickerView.isHidden {
        case true:
            categoryPickerView.isHidden = false
            categoryLabel.isHidden = true
            categoryPickerViewButton.setImage(UIImage(named: ""), for: .normal)
           categoryPickerViewButton.setTitle("Done", for: .normal)
            categoryPickerViewButton.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0), for: .normal)


        case false:
            categoryPickerView.isHidden = true
            categoryLabel.isHidden = false
            categoryPickerViewButton.setImage(UIImage(named: ""), for: .normal)
           categoryPickerViewButton.setTitle("Edit", for: .normal)
            categoryPickerViewButton.setTitleColor(UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0), for: .normal)
        }
        
    }
    
}
