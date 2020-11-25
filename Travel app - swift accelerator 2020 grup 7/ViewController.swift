//
//  ViewController.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Yu Youyou on 24/11/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var OngoingButton: UIButton!
    @IBOutlet weak var UpcomingButton: UIButton!
    @IBOutlet weak var PastButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OngoingButton.layer.cornerRadius = 25
        UpcomingButton.layer.cornerRadius = 25
        PastButton.layer.cornerRadius = 25
    }

    
    
    

}

