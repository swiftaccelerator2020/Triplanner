//
//  PackingListTableViewCell.swift
//  Travel app - swift accelerator 2020 grup 7
//
//  Created by Apple April on 8/12/20.
//

import UIKit

class PackingListTableViewCell: UITableViewCell {

    
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
            for i in PackingListvc?.packingItems as! Array<packingItem>{
                if i.name == self.textLabel?.text{
                    i.checked = true
                }
            }
        } else {
            for i in PackingListvc?.packingItems as! Array<packingItem>{
                if i.name == self.textLabel?.text{
                    i.checked = false
                }
            }
            circleButton.setImage(UIImage(named: "circle"), for: .normal)
        }
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
