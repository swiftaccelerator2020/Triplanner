//
//  EditPackingItemTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 28/11/20.
//

import UIKit

class EditPackingItemTableViewController: UITableViewController {

    var PackingItem: packingItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = PackingItem.name
        doneSwitch.isOn = PackingItem.done
    }

    @IBAction func textFieldUpdated(_ sender: UITextField) {
        PackingItem.name =  sender.text ?? ""
    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        PackingItem.done = sender.isOn
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
