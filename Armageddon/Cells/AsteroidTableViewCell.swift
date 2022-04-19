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
    
    static var changeButtonStatus = false
    static var namesOfAsteroids = [Bool]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        mainView.clipsToBounds = true
        destroyButton.backgroundColor = .systemBlue
    }


    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func destroyButtonAction(_ sender: UIButton) {
        
        if !AsteroidTableViewCell.changeButtonStatus {
            
            AsteroidTableViewCell.namesOfAsteroids.append(false)
            AsteroidTableViewCell.changeButtonStatus = true
        } else {
            
            AsteroidTableViewCell.namesOfAsteroids.append(true)
            AsteroidTableViewCell.changeButtonStatus = false
        }
        
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
            gradientLayer.colors = [leftColorRed, rightColorRed]
        } else {
            gradientLayer.colors = [leftColorGreen, rightColorGreen]
        }
        
        gradientLayer.frame = headerView.bounds
        headerView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
