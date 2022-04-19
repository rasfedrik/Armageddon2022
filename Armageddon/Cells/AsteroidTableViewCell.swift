//
//  AsteroidTableViewCell.swift
//  Armageddon
//


import UIKit

class AsteroidTableViewCell: UITableViewCell {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var headerViewLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
    }


    override func prepareForReuse() {
        super.prepareForReuse()
        gradient(isDanger: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // Градиент headerView
    func gradient(isDanger: Bool) {

        let leftColorGreen = UIColor(red: 207.0/255.0, green: 243.0/255.0, blue: 125.0/255.0, alpha: 1.0).cgColor
        let rightColorGreen = UIColor(red: 125.0/255.0, green: 232.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor

        let leftColorRed = UIColor(red: 255.0/255.0, green: 177.0/255.0, blue: 153.0/255.0, alpha: 1.0).cgColor
        let rightColorRed = UIColor(red: 255.0/255.0, green: 8.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor

        let gradientLayer = CAGradientLayer()

        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        if isDanger {
//            gradeLabel.text = "Опасен"
//            gradeLabel.textColor = .red
            gradientLayer.colors = [leftColorRed, rightColorRed]

            
        } else {
            gradientLayer.colors = [leftColorGreen, rightColorGreen]
//            gradeLabel.text = "Не опасен"
//            gradeLabel.textColor = .black
        }
        
        gradientLayer.frame = headerView.bounds
        headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
}