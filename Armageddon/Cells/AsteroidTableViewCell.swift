//
//  AsteroidTableViewCell.swift
//  Armageddon
//


import UIKit

class AsteroidTableViewCell: UITableViewCell {
    
    static let identifire = "AsteroidTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "AsteroidTableViewCell", bundle: nil)
    }

    @IBOutlet weak var dinoImage: UIImageView!
    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var headerViewLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    
    var buttonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }

    // Кнопка отправляющая астероид на уничтожение
    @IBAction func destroyButtonAction(_ sender: UIButton) {
        buttonAction?()
    }
}
