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

        // Регистрация ячейки
        tableView.register(AsteroidTableViewCell.nib(),
                           forCellReuseIdentifier: AsteroidTableViewCell.identifire)
        
        navigationItem.title = "Армагеддон 2022"
        tableView.dataSource = self
        tableView.delegate = self
        obtainInformationAboutObjects()
        
        // Кнопка перехода к экрану фильтра
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
    
    // Функция перехода к экрану фильтра
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

//         Отображать все астеройды или только опасные
        if UserDefaults.standard.bool(forKey: "isHazard") {
            objects = objects.filter{$0.isPotentiallyHazardousAsteroid!}
        }

        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidTableViewCell.identifire, for: indexPath) as? AsteroidTableViewCell {
            
            guard let data = data else { return UITableViewCell() }
            guard var objects = data.nearEarthObjects?[dates[indexPath.section]]! else { return UITableViewCell() }
            
            
            // Отображать все астеройды или только опасные
            if UserDefaults.standard.bool(forKey: "isHazard") {

                objects = objects.filter{ $0.isPotentiallyHazardousAsteroid! }
            }
            
            let object = objects[indexPath.row]
            guard let isHazard = object.isPotentiallyHazardousAsteroid else { return UITableViewCell() }
            cell.gradient(isDanger: isHazard)
            
            // Название астеройда
            cell.headerViewLabel.text = object.name
            
            
            // Общая информация
            if let closeData = object.closeApproachData,
               let date = closeData.first?.closeApproachDate,
               let distance = closeData.first?.missDistance {
                cell.flightTimeLabel.text = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
                
                // Дистанция
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
            guard let minDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMin,
                  let maxDiametr = object.estimatedDiameter?.meters?.estimatedDiameterMax
            else {
                return UITableViewCell()
            }
            cell.diameterLabel.text = "Диаметр: \(minDiametr.average(x: Double(maxDiametr))) м"

            let size = Int(minDiametr.average(x: Double(maxDiametr)))!
            if size <= 100 {
                cell.asteroid.image = cell.small
            } else if size > 100 && size < 300 {
                cell.asteroid.image = cell.middle
            } else {
                cell.asteroid.image = cell.big
            }
       
            
            // Добавление астеройда в список на уничтожение
            cell.buttonAction = { [weak self] in

                guard let asteroidKey = self?.dates[indexPath.section] else { return }
                
                let asteroid = Objects(keys: asteroidKey, values: [object])
                
                if KillListViewController.killListArray.contains(where: { item -> Bool in
                    item.keys == asteroidKey && item.values == [object]
                }) {
                    KillListViewController.killListArray.remove(at: indexPath.section)
                    cell.destroyButton.backgroundColor = .systemBlue
                } else {
                    KillListViewController.killListArray.append(asteroid)
                    cell.destroyButton.backgroundColor = .red
                }
            }

            return cell
        }
        
        return UITableViewCell()
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // Переход к описанию астеройда
        let vc = storyboard?.instantiateViewController(identifier: DescriptionAsteroidViewController.identifire) as! DescriptionAsteroidViewController
        
        if let path = data?.nearEarthObjects?[dates[indexPath.section]]![indexPath.row] {
            vc.title = path.name

            DescriptionAsteroidViewController.asteroidId = path.id!

            if let closeData = path.closeApproachData,
               let date = closeData.first?.closeApproachDate,
               let distance = closeData.first?.missDistance {
                vc.flightTimeText = "Подлетает \((date.toDate() ?? Date()).toStringLocal())"
                
                // Дистанция
                if UserDefaults.standard.integer(forKey: "unitsType") == 0 {
                    vc.flightDistanceText = "на расстояние \((distance.kilometers!.cleanPrice())) км"
                } else {
                    vc.flightDistanceText = "на расстояние \((distance.lunar!.cleanPrice())) л. орб."
                }
            }
            

            guard let minDiametr = path.estimatedDiameter?.meters?.estimatedDiameterMin,
                  let maxDiametr = path.estimatedDiameter?.meters?.estimatedDiameterMax
            else {
                return
            }
            vc.diametrText = "Диаметр: \(minDiametr.average(x: Double(maxDiametr))) м"
            
            
            // Кнопка
            vc.buttonAction = { [weak self] in

                guard let asteroidKey = self?.dates[indexPath.section] else { return }

                let asteroid = Objects(keys: asteroidKey, values: [path])

                if KillListViewController.killListArray.contains(where: { item -> Bool in
                    item.keys == asteroidKey && item.values == [path]
                }) {
                    KillListViewController.killListArray.remove(at: indexPath.row)
                } else {
                    KillListViewController.killListArray.append(asteroid)
                    
                }
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
