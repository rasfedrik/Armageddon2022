//
//  ChangeDistanceTableViewCell.swift
//  Armageddon
//
//  Created by Семен Беляков on 17.04.2022.
//

import UIKit


class ChangeDistanceTableViewCell: UITableViewCell {
    
    static let identifire = "ChangeDistanceCellId"
    static func nib() -> UINib {
        return UINib(nibName: "ChangeDistanceTableViewCell", bundle: nil)
    }

    @IBOutlet weak var changeDistanceLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .systemGray3
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
