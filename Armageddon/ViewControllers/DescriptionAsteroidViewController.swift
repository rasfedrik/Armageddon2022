//
//  DescriptionAsteroidViewController.swift
//  Armageddon
//
//  Created by Семен Беляков on 18.04.2022.
//

import UIKit

class DescriptionAsteroidViewController: UIViewController {
    
    static let identifire = "DescriptionAsteroidViewController"

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var diametrLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var approachTime: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var orbitLabel: UILabel!
    @IBOutlet weak var isHazardLabel: UILabel!
    @IBOutlet weak var destroyButton: UIButton!
    
    var nameText = ""
    var diametrText = ""
    var speedText = ""
    var approachText = ""
    var distanceText = ""
    var orbitText = ""
    var isHazardText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = nameText
        diametrLabel.text = diametrText
        speedLabel.text = speedText
        approachTime.text = approachText
        distanceLabel.text = distanceText
        orbitLabel.text = orbitText
        isHazardLabel.text = isHazardText
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
}

extension DescriptionAsteroidViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") {
            cell.textLabel?.text = "1"
            return cell
        }
        return UITableViewCell()
    }

}
