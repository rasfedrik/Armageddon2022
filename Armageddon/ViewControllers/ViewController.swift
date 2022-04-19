//
//  ViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 13.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    static let identifire = "ViewControllerList"
    
    private let networkManager = NetworkManager()
    
    var arrayWithHazard = [Bool]()
    
    private var data: SpaceObjects?
    private var dates = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Армагеддон 2022"
        tableView.dataSource = self
        tableView.delegate = self
        obtainInformationAboutObjects()
        
        let filterButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease"),
            style: .plain,
            target: self,
            action: #selector(goToFilter))
        navigationItem.rightBarButtonItem = filterButton
    }

    @objc func goToFilter() {
        let filterVC = storyboard?.instantiateViewController(identifier: FilterViewController.identifire) as! FilterViewController
        
        navigationController?.pushViewController(filterVC, animated: true)
    }
    
    // Получение информации об объектах
    private func obtainInformationAboutObjects() {
        networkManager.obtainAsteroids { result in
            
            self.data = result
            guard let objects = result.nearEarthObjects else { return }
            
            self.dates = Array(objects.keys).sorted(by: { $0 < $1 })
        }
    }
}

// Таблица
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        
        guard let nearObjects = data.nearEarthObjects else { return 0 }
        
        return nearObjects[dates[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let data = data else { return UITableViewCell() }
        
        guard let object = data.nearEarthObjects?[dates[indexPath.section]]![indexPath.row] else { return UITableViewCell() }

        if let cell = tableView.dequeueReusableCell(withIdentifier: "AsteroidTableViewCell", for: indexPath) as? AsteroidTableViewCell {

            cell.headerViewLabel.text = object.name

            if let closeData = object.closeApproachData,                                                                     //    let distance = closeData.first{$0.orbitingBody == "Earth" }
               let date = closeData.first?.closeApproachDate,
               let distance = closeData.first?.missDistance {
                cell.flightTimeLabel.text = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
                cell.rangeLabel.text = "на расстояние \((distance.kilometers!.cleanPrice())) км"
            }
            
            // Оценка опасности объекта
            guard let isHazard = object.isPotentiallyHazardousAsteroid else { return UITableViewCell() }
            
            cell.gradient(isDanger: isHazard)

            if isHazard {
                cell.gradeLabel.text = "Опасен"
                cell.gradeLabel.textColor = .red
            } else {
                cell.gradeLabel.text = "Не опасен"
                cell.gradeLabel.textColor = .black
            }

            // Размер объекта
            let minDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMin
            let maxDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMax
            
            cell.diameterLabel.text = "Диаметр \(minDiametr!.average(x: Double(maxDiametr!))) м"
            
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let descriptionVC = storyboard?.instantiateViewController(identifier: DescriptionAsteroidViewController.identifire) as! DescriptionAsteroidViewController
        
        let path = data?.nearEarthObjects?[dates[indexPath.section]]![indexPath.row]
        navigationController?.pushViewController(descriptionVC, animated: true)
        
        descriptionVC.title = path?.name
    }
}

// Вычисление среднего размера объекта
extension Double {
    func average(x: Double) -> String {
        return String((Int(x + self) / 2))
    }
}

// Изменение отображения формата даты
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



