//
//  ViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let networkManager = NetworkManager()
    
    var data: SpaceObjects?
//    var nearEarthObject = [NearEarthObject]()
    var dates = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        information()
//        registeredCustomTableViewCell()
    }

    private func information() {
        networkManager.obtainAsteroids { result in
            
            self.data = result
            guard let objects = result.nearEarthObjects else { return }
            
            self.dates = Array(objects.keys)
            
            }
        }
    
    private func registeredCustomTableViewCell() {
        let nib = UINib(nibName: "AsteroidTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AsteroidTableViewCell")
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        
        guard let nearObjects = data.nearEarthObjects else {
            return 0
        }
        
        return nearObjects[dates[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = data else { return UITableViewCell() }
        
        guard let object = data.nearEarthObjects?[dates[indexPath.section]]![indexPath.row] else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidTableViewCell") as? AsteroidTableViewCell {

            cell.headerViewLabel.text = object.name
            
            let minDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMin
            let maxDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMax
         
            if let closeData = object.closeApproachData,                                                            //    let distance = closeData.first{$0.orbitingBody == "Earth" }
               let date = closeData.first?.closeApproachDate,
               let distance = closeData.first?.missDistance {
                cell.flightTimeLabel.text = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
                cell.rangeLabel.text = "на расстояние \((distance.kilometers!.cleanPrice())) км"
            }
            
            cell.gradeLabel.text = (object.isPotentiallyHazardousAsteroid ?? false ) ? "Опасен" : "Не опасен"
            
            cell.diameterLabel.text = "Диаметр \(minDiametr!.average(x: Double(maxDiametr!))) м"
            

            
//            cell.rangeLabel.text =
            
            //      "is_potentially_hazardous_asteroid": true, // Опасность
            //      "estimated_diameter": { // Диаметр

            //            "lunar": "117.7689258646",
            //            "kilometers": "45290438.204452618",
            //          },
            
            
            return cell
        }
        return UITableViewCell()
    }
}

extension Double {
    func average(x: Double) -> String {
        return String((Int(x + self) / 2))
    }
}

extension Date {
    
    func toStringUS() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func toStringLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.calendar = .current
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
//    func tomorrow() -> Date {
//        return Date(timeIntervalSinceNow: 86400)
//    }
}

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func cleanPrice() -> String {
            let doubleValue = Int(Double(self) ?? 0.0)
        
            let formatter = NumberFormatter()
        
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(doubleValue)"
        }
    
}



