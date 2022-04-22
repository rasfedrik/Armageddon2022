//
//  KillListViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 19.04.2022.
//

import UIKit

class KillListViewController: UIViewController {

    @IBOutlet weak var tableViewKillList: UITableView!
    private let networkManager = NetworkManager()

    struct Objects {
        var keys : String?
        var values : [SpaceObjects.NearEarthObject]?
    }

    static var killListArray = [Objects]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewKillList.register(AsteroidTableViewCell.nib(), forCellReuseIdentifier: AsteroidTableViewCell.identifire)
        tableViewKillList.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        fillingInTheTable()
        self.tableViewKillList.reloadData()
    }
}

extension KillListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return KillListViewController.killListArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objectsCount = KillListViewController.killListArray[section].values else { return 0 }
        print(objectsCount.count)
        return objectsCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidTableViewCell.identifire, for: indexPath) as? AsteroidTableViewCell {
 
            guard let data = KillListViewController.killListArray[indexPath.section].values?[indexPath.row] else { return UITableViewCell() }
        guard let isHazard = data.isPotentiallyHazardousAsteroid else { return UITableViewCell() }
        
        cell.headerViewLabel.text = data.name
        
        if let closeData = data.closeApproachData,
           let date = closeData.first?.closeApproachDate,
           let distance = closeData.first?.missDistance {
            cell.flightTimeLabel.text = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
            
            
            if UserDefaults.standard.integer(forKey: "unitsType") == 0 {
                cell.rangeLabel.text = "на расстояние \((distance.kilometers!.cleanPrice())) км"
            } else {
                cell.rangeLabel.text = "на расстояние \((distance.lunar!.cleanPrice())) л. орб."
            }
        }
        
        // Оценка опасности объекта
        cell.gradient(isDanger: isHazard)
        if isHazard {
            cell.gradeLabel.text = "Опасен"
            cell.gradeLabel.textColor = .red
        } else {
            cell.gradeLabel.text = "Не опасен"
            cell.gradeLabel.textColor = .black
        }


        // Размер объекта
        let minDiametr = data.estimatedDiameter?.meters?.estimatedDiameterMin
        let maxDiametr = data.estimatedDiameter?.meters?.estimatedDiameterMax

        cell.diameterLabel.text = "Диаметр \(minDiametr!.average(x: Double(maxDiametr!))) м"
            
            return cell
        }
     return UITableViewCell()
    }
}
