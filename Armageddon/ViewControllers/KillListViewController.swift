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
    
    private var data: SpaceObjects?
    private var dates = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.tableViewKillList.reloadData()
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewKillList.dataSource = self
        obtainInformationAboutObjects()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableViewKillList.reloadData()
    }
    
    
    private func obtainInformationAboutObjects() {
        networkManager.obtainAsteroids { result in
            
            self.data = result
            guard let objects = result.nearEarthObjects else { return }
            
            self.dates = Array(objects.keys).sorted(by: { $0 < $1 })
        }
    }
}

extension KillListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard let data = data else { return 0 }
//        guard let nearObjects = data.nearEarthObjects else { return 0 }
//
//        return nearObjects[dates[section]]!.count
        
        AsteroidTableViewCell.namesOfAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "killListCell", for: indexPath)
            guard let data = data else { return UITableViewCell() }
        
            guard let object = data.nearEarthObjects?[dates[indexPath.section]]![indexPath.row] else { return UITableViewCell() }
        
            for i in AsteroidTableViewCell.namesOfAsteroids {
                if i {
                    cell.textLabel?.text = object.name
                    
                }
            }
            if AsteroidTableViewCell.namesOfAsteroids[indexPath.row] {
                cell.textLabel?.text = object.name
            }
//        tableViewKillList.reloadData()
            return cell
    }
}
