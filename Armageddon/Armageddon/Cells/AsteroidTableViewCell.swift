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
    
    func configure(data: SpaceObjects?, dates: [String], indexPath: IndexPath) {
        let objects = data?.nearEarthObjects?[dates[indexPath.section]]!
        let object = objects![indexPath.row]
        
        // Название астеройда
        headerViewLabel.text = object.name
        
        // Общая информация
        if let closeData = object.closeApproachData,
           let date = closeData.first?.closeApproachDate,
           let distance = closeData.first?.missDistance {
            flightTimeLabel.text = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
            
            // Дистанция
            if UserDefaults.standard.integer(forKey: "unitsType") == 0 {
                rangeLabel.text = "на расстояние \((distance.kilometers!.cleanPrice())) км"
            } else {
                rangeLabel.text = "на расстояние \((distance.lunar!.cleanPrice())) л. орб."
            }
        }
        
        // Размер объекта
        guard let minDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMin,
              let maxDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMax
        else { return }
        
        diameterLabel.text = "Диаметр: \(minDiametr.average(x: Double(maxDiametr))) м"

        let size = Int(minDiametr.average(x: Double(maxDiametr)))!
        let asteroidImage = headerView.asteroid
        
        if size <= 100 {
            asteroidImage.image = headerView.small
        } else if size > 100 && size < 300 {
            asteroidImage.image = headerView.middle
        } else {
            asteroidImage.image = headerView.big
        }
    }
    
    func statusHazard(_ isHazard: Bool) {
        if isHazard {
            gradeLabel.text = "Опасен"
            gradeLabel.textColor = .red
            headerView.leftColor = UIColor.leftColorRed
            headerView.rightColor = UIColor.rightColorRed

        } else {
            headerView.leftColor = UIColor.leftColorGreen
            headerView.rightColor = UIColor.rightColorGreen
            gradeLabel.text = "Не опасен"
            gradeLabel.textColor = .black
        }
    }
}

