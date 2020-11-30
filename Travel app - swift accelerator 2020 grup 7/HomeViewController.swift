//  ViewController.swift
//  Travel app - swift accelerator 2020 grup 7


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var OngoingButton: UIButton!
    @IBOutlet weak var UpcomingButton: UIButton!
    @IBOutlet weak var PastButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //adds the corner radius curve
        OngoingButton.layer.cornerRadius = 25
        UpcomingButton.layer.cornerRadius = 25
        PastButton.layer.cornerRadius = 25
    }

    
    
    

}

