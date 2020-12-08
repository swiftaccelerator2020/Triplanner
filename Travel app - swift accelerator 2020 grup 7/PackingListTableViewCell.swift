//
//  PackingListTableViewCell.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Apple April on 8/12/20.
//

import UIKit

class PackingListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var circleButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func circleButtonPressed(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
