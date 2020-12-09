//
//  AddSpendingViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by nicole on 9/12/20.
//

import UIKit

class AddSpendingViewController: UITableViewController {

    @IBOutlet weak var spendingNameTextField: UITextField!
    
    @IBOutlet weak var spendingCostTextField: UITextField!
    
    @IBOutlet weak var spendingCategoryTextField: UITextField!
    
    @IBAction func spendingNameTextfieldUpdated(_ sender: Any) {
        
    }
    @IBAction func spendingCostTextfieldUpdated(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
