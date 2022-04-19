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
    @IBOutlet weak var showHazards: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray3
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switcherAction(_ sender: UISwitch) {
        
        if sender.isOn {
            FilterViewController.isHazard = true
            print(FilterViewController.isHazard)
        } else {
            FilterViewController.isHazard = false
            print(FilterViewController.isHazard)
        }
    }
    
}
