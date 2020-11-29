//
//  BudgetViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by rochelletxy on 29/11/20.
//

import UIKit

class BudgetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    class budgetInfoItem {
        var name: String
        
        init(name: String) {
            self.name = name
        }
    }
    
    var BudgetInfoItem = [
        budgetInfoItem(name: "Total Budget: "),
        budgetInfoItem(name: "Amount Spent: "),
        budgetInfoItem(name: "Amount Left: ")
    ]
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
