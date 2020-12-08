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
    var newlyCreatedEvent: DayEvent? = nil
    var itinEvents: Array<DayEvent> = []
    
    func printTextOnButton(titleString: String){
        print("working")
        print(titleString)
        itinOverviewLabel.text = titleString
//        itinButtonLabel.setTitle(titleString, for: .normal)
    }
    
    override func viewDidLoad() {
        ItinButtonOutlet.setTitle("New Itinerary", for: .normal)
        super.viewDidLoad()
        if itinEvents .isEmpty == false{
            itinOverviewLabel.text = itinEvents[0].destination
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController{
            if let vc = navigationVC.topViewController as? ItinTableViewController{
        vc.delegate = self
            }
        }
        
        if let dest = segue.destination as? ItinEventViewController{
            
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
        
    @IBAction func backToItinEventsTableViewController (with segue: UIStoryboardSegue){
        if let source = segue.source as? ItinEventViewController{
            print("backToOverviewViewController segue result:", source.event)
            switch source.event {
            case nil:
                print("source.event is nil")
            default:
                newlyCreatedEvent = source.event
            }
            if itinEvents.isEmpty != true{
                itinOverviewLabel.text = "\(itinEvents[0].destination),\(itinEvents[0].date)"
            }
            print("itinEvents:", itinEvents)
    }
}
    
    @IBAction func backToOverViewController(with segue: UIStoryboardSegue){
        
    }


}
