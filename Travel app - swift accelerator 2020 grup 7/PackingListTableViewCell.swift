//
//  PackingListTableViewCell.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Apple April on 8/12/20.
//

import UIKit

class PackingListTableViewCell: UITableViewCell {
    var delegate: PackingListCheckedDelegate?

    
    @IBOutlet weak var circleButton: UIButton!
    
    var isChecked = false
    weak var PackingListvc: PackingListTableViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func circleButtonPressed(_ sender: Any) {
        isChecked.toggle()
        
        if isChecked {
            circleButton.setImage(UIImage(named: "checkmark.circle"), for: .normal)
            PackingListvc?.isChecked = true
            print(PackingListvc?.isChecked)
            print("isChecked",isChecked)
        } else {
            circleButton.setImage(UIImage(named: "circle"), for: .normal)
        }
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
