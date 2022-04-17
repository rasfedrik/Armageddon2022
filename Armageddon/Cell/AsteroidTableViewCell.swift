//
//  AsteroidTableViewCell.swift
//  Armageddon
//


import UIKit

class AsteroidTableViewCell: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var headerViewLabel: UILabel!
    @IBOutlet weak var mainView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.backgroundColor = .white

        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIView {
    
}
