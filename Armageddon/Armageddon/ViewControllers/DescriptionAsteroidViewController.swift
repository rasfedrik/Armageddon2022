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

    static var asteroidDescription: AsteroidData?
    
    @IBOutlet weak var orbitTableView: UITableView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var diametrLabel: UILabel!
    @IBOutlet weak var isHazardLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    @IBOutlet weak var flightTimeLabel: UILabel!
    @IBOutlet weak var flightDistanceLabel: UILabel!
    
    var buttonAction: (() -> ())?
    
    static var asteroidId = ""
    var flightTimeText = ""
    var flightDistanceText = ""
    var diametrText = ""
    var nameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orbitTableView.register(ApproachTableViewCell.nib(),
                                forCellReuseIdentifier: ApproachTableViewCell.identifire)
        asteroidData()

    
        descriptionView.layer.cornerRadius = 10
        descriptionView.clipsToBounds = true
        orbitTableView.dataSource = self
        orbitTableView.delegate = self
        flightTimeLabel.text = flightTimeText
        flightDistanceLabel.text = flightDistanceText
        diametrLabel.text = diametrText
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    // Получение информации об объектах
    func asteroidData() {
        networkManager.asteroidData(id: DescriptionAsteroidViewController.asteroidId) { result in   
            DispatchQueue.main.async {
                DescriptionAsteroidViewController.asteroidDescription = result
                self.orbitTableView.reloadData()
                
                self.nameLabel.text = result.name!
                if result.isPotentiallyHazardousAsteroid! {
                    self.isHazardLabel.textColor = .red
                    self.isHazardLabel.text = "Опасен"
                } else {
                    self.isHazardLabel.text = "Не опасен"
                    self.isHazardLabel.textColor = .black
                }
            }
        }
    }

    @IBAction func addKillList(_ sender: UIButton) {
        buttonAction?()
    }
}

extension DescriptionAsteroidViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Сближения"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let close = DescriptionAsteroidViewController.asteroidDescription?.closeApproachData else { return 0 }
        return close.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cellOrbit = orbitTableView.dequeueReusableCell(withIdentifier: ApproachTableViewCell.identifire, for: indexPath) as? ApproachTableViewCell {
            
            guard let closeApproachData = DescriptionAsteroidViewController.asteroidDescription?.closeApproachData?[indexPath.row]
            else { return UITableViewCell() }
            
            cellOrbit.orbit.text = closeApproachData.orbitingBody?.rawValue ?? "Нет данных"
            cellOrbit.timeMaxApproach.text = "Сближение \(closeApproachData.closeApproachDate?.toDate()?.toStringLocal() ?? "Нет данных")"
            
            if UserDefaults.standard.integer(forKey: "unitsType") == 0 {
                cellOrbit.distance.text = "на расстояние \(closeApproachData.missDistance?.kilometers?.cleanPrice() ?? "Нет данных") км"
            } else {
                cellOrbit.distance.text = "на расстояние \(closeApproachData.missDistance?.lunar?.cleanPrice() ?? "Нет данных") л. орб."
            }
            
            cellOrbit.speed.text = "Скорость \(Int(Double(closeApproachData.relativeVelocity?.kilometersPerSecond! ?? "Нет данных")!)) км/с"
            return cellOrbit
        }
     return UITableViewCell()
    }
}
