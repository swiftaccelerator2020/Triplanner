//
//  AddSpendingViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by nicole on 9/12/20.
//

import UIKit

class AddSpendingViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
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
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 17)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = categories[row]
        pickerLabel?.textColor = UIColor.blue

        return pickerLabel!
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
    
        //--- add UIToolBar on keyboard and Done button on UIToolBar ---//
                self.addDoneButtonOnKeyboard()
        self.spendingCostTextField.delegate = self
        //trying to make textview dismissible
        spendingNotesTextView.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSave"{
        if self.isExistingItem == true{
        self.budgetItem?.name = spendingNameTextField.text ?? ""
            self.budgetItem?.cost = Int(spendingCostTextField.text ?? "") ?? 0
            self.budgetItem?.category = categoryLabel.text ?? "Other"
            self.budgetItem?.notes = spendingNotesTextView.text ?? ""
            
            }else{
                self.budgetItem = BudgetItem(name: spendingNameTextField.text ?? "", cost: Int(spendingCostTextField.text ?? "") ?? 0, category: categoryLabel.text ?? "Other", notes: spendingNotesTextView.text ?? "")
                print("created item here", self.budgetItem)
            
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
    
    
    @IBAction func spendingNameEditingEnd(_ sender: Any) {
        spendingNameTextField.resignFirstResponder()
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
        
        self.spendingCostTextField.inputAccessoryView = doneToolbar
        
      }
      
      @objc func doneButtonAction()
      {
        self.spendingCostTextField.resignFirstResponder()
      }
    
    //trying to make the textview dismissible
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if(text == "\n") {
                spendingNotesTextView.resignFirstResponder()
                return false
            }
            return true
        }
    
    
}

extension UITextField {
func addDoneButtonOnKeyBoardWithControl() {
    let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
keyboardToolbar.sizeToFit()
keyboardToolbar.barStyle = .default
let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.endEditing(_:)))
keyboardToolbar.items = [flexBarButton, doneBarButton]
self.inputAccessoryView = keyboardToolbar
}
    
 
    
}
