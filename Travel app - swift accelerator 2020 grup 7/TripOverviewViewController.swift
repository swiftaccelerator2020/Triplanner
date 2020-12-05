//
//  TripOverviewViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 4/12/20.
//

import UIKit

protocol DataDelegate {
    func printTextOnButton(titleString: String)
}

class TripOverviewViewController: UIViewController, DataDelegate {
    @IBOutlet weak var itinButtonLabel: UIButton!
    
    func printTextOnButton(titleString: String){
        print("working")
        print(titleString)
//        itinButtonLabel.setTitle(titleString, for: .normal)
    }
    
    override func viewDidLoad() {
        itinButtonLabel.setTitle("Itinerary", for: .normal)
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let vc = navigationVC.topViewController as? ItinTableViewController{
        vc.delegate = self
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

    @IBAction func itinButton(_ sender: Any) {
    }
}


