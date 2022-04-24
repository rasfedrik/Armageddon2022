//
//  DescriptionTableViewCell.swift
//  Armageddon
//
//  Created by Семен Беляков on 17.04.2022.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    static let identifire = "DescriptionCellId"
    static func nib() -> UINib {
        return UINib(nibName: "DescriptionTableViewCell", bundle: nil)
    }

    @IBOutlet weak var descriptionText: UILabel!    
    @IBOutlet weak var showHazards: UISwitch! {
        didSet {
            showHazards.isOn = UserDefaults.standard.bool(forKey: "isHazard")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray3
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func switcherAction(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isHazard")
    }
    
}
