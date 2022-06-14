//
//  ApproachTableViewCell.swift
//  Armageddon
//
//  Created by Семен Беляков on 26.04.2022.
//

import UIKit

class ApproachTableViewCell: UITableViewCell {

    static let identifire = "ApproachCell"
    static func nib() -> UINib {
        return UINib(nibName: "ApproachTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var timeMaxApproach: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var orbit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code ApproachCell
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
