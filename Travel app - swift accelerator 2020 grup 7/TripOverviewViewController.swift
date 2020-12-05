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
    @IBOutlet weak var ItinButtonOutlet: UIButton!
    
    @IBOutlet weak var itinOverviewLabel: UILabel!
    
    var itinOverviewText: String = "itinOverviewText"
    
    func printTextOnButton(titleString: String){
        print("working")
        print(titleString)
        itinOverviewLabel.text = titleString
//        itinButtonLabel.setTitle(titleString, for: .normal)
    }
    
    override func viewDidLoad() {
        ItinButtonOutlet.setTitle("New Itinerary", for: .normal)
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
    
    @IBAction func backToOverviewViewController(with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventViewController{
            print("backToOverviewViewController segue result:", source.event)
            
        }
    }
}


