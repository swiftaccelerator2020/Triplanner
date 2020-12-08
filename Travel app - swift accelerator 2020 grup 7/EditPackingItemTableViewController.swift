//
//  EditPackingItemTableViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 28/11/20.
//

import UIKit

class EditPackingItemTableViewController: UITableViewController {

    var PackingItem: packingItem!
    var newPackingItem = false
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if PackingItem != nil {
            nameTextField.text = PackingItem.name
        } else {
            PackingItem = packingItem(name: "")
        }
    }

    @IBAction func textFieldUpdated(_ sender: UITextField) {
        PackingItem.name =  sender.text ?? ""
    }

    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
