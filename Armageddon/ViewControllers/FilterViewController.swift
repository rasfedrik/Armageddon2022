//
//  FilterViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 17.04.2022.
//

import UIKit

class FilterViewController: UIViewController {

    static let identifire = "FilterViewController"
    static var isHazard = false
    
    let userDefaults = UserDefaults.standard
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Фильтр"
        
        filterTableView.dataSource = self
        filterTableView.delegate = self
        
        filterTableView.tableFooterView = UIView()
        filterTableView.layer.cornerRadius = 10
        filterTableView.clipsToBounds = true
        filterTableView.layer.masksToBounds = true
        
        // Регистрация ячеек
        filterTableView.register(ChangeDistanceTableViewCell.nib(), forCellReuseIdentifier: ChangeDistanceTableViewCell.identifire)
        filterTableView.register(DescriptionTableViewCell.nib(), forCellReuseIdentifier: DescriptionTableViewCell.identifire)
        
        // Кнопка "Применить"
        let applyButton = UIBarButtonItem.init(
            title: "Применить",
            style: .plain,
            target: self,
            action: #selector(apply(_:)))
        
        navigationItem.rightBarButtonItem = applyButton
    }
    
    @objc func apply(_ sender: Any) {
        
        if FilterViewController.isHazard {
            let vc = storyboard?.instantiateViewController(
                identifier: ListOfAsteroidsViewController.identifire) as! ListOfAsteroidsViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if indexPath.row == 0 {
            if let distanceCell = filterTableView.dequeueReusableCell(withIdentifier: "ChangeDistanceCellId", for: indexPath) as? ChangeDistanceTableViewCell {
                return distanceCell
            }
            
        } else if indexPath.row == 1 {
            if let hazardCell = filterTableView.dequeueReusableCell(withIdentifier: "DescriptionCellId", for: indexPath) as? DescriptionTableViewCell {
                
                if hazardCell.showHazards.isOn {
                    FilterViewController.isHazard = true
                } else {
                    FilterViewController.isHazard = false
                }
                
            return hazardCell
            }
        }
        return UITableViewCell()
    }
}
 
