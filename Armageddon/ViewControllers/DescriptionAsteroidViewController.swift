//
//  DescriptionAsteroidViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 18.04.2022.
//

import UIKit

class DescriptionAsteroidViewController: UIViewController {
    
    static let identifire = "DescriptionAsteroidViewController"

    private let networkManager = NetworkManager()

    static var asteroidDescription: [AsteroidData]?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var diametrLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var approachTime: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var isHazardLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var flightDistanceLabel: UILabel!
    
    var buttonAction: (() -> ())?
    
    var asteroidId = ""
//    var nameText = ""
//    var diametrText = ""
//    var speedText = ""
//    var approachText = ""
//    var distanceText = ""
//    var orbitText = ""
//    var isHazardText = ""
//    var flightTimeText = ""
//    var flightDistanceText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        asteroidData()
        descriptionView.layer.cornerRadius = 10
        descriptionView.clipsToBounds = true

        
        
//        if isHazardText == "Опасен" {
//            isHazardLabel.textColor = .red
//        }
//        isHazardLabel.text = isHazardText
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    // Получение информации об объектах
    func asteroidData() {
        networkManager.asteroidData(id: asteroidId) { result in
            DescriptionAsteroidViewController.asteroidDescription?.append(result)

            DispatchQueue.main.async {
                
                self.nameLabel.text = result.name!
                self.speedLabel.text = "\((result.closeApproachData?.first?.relativeVelocity?.kilometersPerSecond) ?? "нет данных") км/с"
                self.approachTime.text = "approachText"
                self.distanceLabel.text = "distanceText"
                self.orbitLabel.text = result.closeApproachData?.first?.orbitingBody?.rawValue
                self.flightTimeLabel.text = "flightTimeText"
                self.flightDistanceLabel.text = "flightDistanceText"
            }
        }
    }

    @IBAction func addKillList(_ sender: UIButton) {
        buttonAction?()
    }
}

