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
      
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return asteroids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "cellId") {
            cell = reuseCell
//            cell.textLabel?.text = String(indexPath.row)
        } else {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellId")
//            cell.textLabel?.text = String(indexPath.row)
        }
        configureCell(cell: &cell, for: indexPath)
        return cell
    }
}

extension ViewController {
    private func configureCell(cell: inout UITableViewCell, for indexPath: IndexPath) {
        var configuration = cell.defaultContentConfiguration()
    
//        configuration.text = asteroids[indexPath.row].earthObjects[indexPath.section].title
//        configuration.text = asteroids[indexPath.section].nearEarthObjects?.first
        
        
        cell.contentConfiguration = configuration
    }
}




