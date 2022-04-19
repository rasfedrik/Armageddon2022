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
    private var dates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewKillList.dataSource = self
        obtainInformationAboutObjects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewKillList.reloadData()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        AsteroidTableViewCell.namesOfAsteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "killListCell", for: indexPath)
            guard let data = data else { return UITableViewCell() }
        
            guard let object = data.nearEarthObjects?[dates[indexPath.section]]![indexPath.row] else { return UITableViewCell() }
        
            
            return cell
    }
}
