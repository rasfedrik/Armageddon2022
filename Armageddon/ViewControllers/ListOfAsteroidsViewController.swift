//
//  ListOfAsteroidsViewController.swift
//  Armageddon


import UIKit

class ListOfAsteroidsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    static let identifire = "ListOfAsteroidsViewController"

    private let networkManager = NetworkManager()

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
        tableView.register(AsteroidTableViewCell.nib(), forCellReuseIdentifier: AsteroidTableViewCell.identifire)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
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
extension ListOfAsteroidsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dates.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = data else { return 0 }
        guard var objects = data.nearEarthObjects?[dates[section]]! else { return 0 }
        
        if UserDefaults.standard.bool(forKey: "isHazard") {
            objects = objects.filter{$0.isPotentiallyHazardousAsteroid!}
        }
        
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidTableViewCell.identifire, for: indexPath) as? AsteroidTableViewCell {
            
            guard let data = data else { return UITableViewCell() }
            guard var objects = data.nearEarthObjects?[dates[indexPath.section]]! else { return UITableViewCell() }
            
            if UserDefaults.standard.bool(forKey: "isHazard") {
                objects = objects.filter{$0.isPotentiallyHazardousAsteroid!}
            }
            
            let object = objects[indexPath.row]
            guard let isHazard = object.isPotentiallyHazardousAsteroid else { return UITableViewCell() }
            
            cell.headerViewLabel.text = object.name
            
            if let closeData = object.closeApproachData,
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
            let minDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMin
            let maxDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMax

            cell.diameterLabel.text = "Диаметр \(minDiametr!.average(x: Double(maxDiametr!))) м"

            
            // Добавление астеройда в список на уничтожение
            cell.buttonAction = { [weak self] in
                KillListViewController.killListArray.append(
                    KillListViewController.Objects(keys: self?.dates[indexPath.section] ?? "",
                                                   values: [object]))
            }
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


