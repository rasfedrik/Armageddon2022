//
//  FilterViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 17.04.2022.
//

import UIKit

class FilterViewController: UIViewController {

    static let identifire = "FilterViewController"
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Фильтр"
        
        filterTableView.dataSource = self
        filterTableView.delegate = self
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        filterTableView.reloadData()
    }
    
    @objc func apply(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
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
            return hazardCell
            }
        }
        return UITableViewCell()
    }
}
