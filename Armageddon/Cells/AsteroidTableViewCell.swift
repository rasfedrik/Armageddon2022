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
    
    var asteroid: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let small = UIImage(named: "small_asteroid")
    let middle = UIImage(named: "middle_asteroid")
    let big = UIImage(named: "big_asteroid")

    @IBOutlet weak var dinoImage: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var rangeLabel: UILabel!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var diameterLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var headerViewLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
//    {
//        didSet {
//            if UserDefaults.standard.bool(forKey: "colorButton") {
//                destroyButton.backgroundColor = .red
//            } else {
//                destroyButton.backgroundColor = .systemBlue
//            }
//        }
//    }
    
    var buttonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupConstraints()
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
    
    
    // Кнопка отправляющая астероид на уничтожение
    @IBAction func destroyButtonAction(_ sender: UIButton) {
        buttonAction?()
    }
    
    
    // Констрейнты астероида
    func setupConstraints() {
        headerView.addSubview(asteroid)

        asteroid.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 27).isActive = true
        asteroid.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -61).isActive = true
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
