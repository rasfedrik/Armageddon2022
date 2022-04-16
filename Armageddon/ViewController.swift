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
    
    var asteroids = [Asteroid]()
    var nearEarthObject = [NearEarthObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        information()
    }

    func information() {
        networkManager.obtainAsteroids { result in
            self.asteroids.append(result)
            for item in self.asteroids {
                for (_, value) in item.nearEarthObjects! {
                    for i in value {
                        self.nearEarthObject.append(i)
                    }
                }
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return nearEarthObject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cellId") {
            cell = reuseCell
        } else {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellId")
        }
        configureCell(cell: &cell, for: indexPath)
        return cell
    }
}

extension ViewController {
    private func configureCell(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
    
        configuration.text = nearEarthObject[indexPath.row].name
//        configuration.text = asteroids[indexPath.section].nearEarthObjects?.first
        
        
        cell.contentConfiguration = configuration
    }
}




