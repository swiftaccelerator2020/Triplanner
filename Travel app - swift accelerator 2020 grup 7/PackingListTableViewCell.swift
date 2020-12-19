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
            var count = -1
            for i in PackingListvc?.packingItems as! Array<PackingItem>{
                count += 1
                if i.name == self.textLabel?.text{
                    PackingListvc?.packingItems[count].checked = true
                }
            }
        } else {
            var count = -1
            for i in PackingListvc?.packingItems as! Array<PackingItem>{
                count += 1
                if i.name == self.textLabel?.text{
                    PackingListvc?.packingItems[count].checked = false
                }
            }
            circleButton.setImage(UIImage(named: "circle"), for: .normal)
            PackingItem.saveToFile(packingItems: PackingListvc?.packingItems ?? [])
        }
         
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
