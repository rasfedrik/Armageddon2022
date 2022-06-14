//
//  HeaderView.swift
//  Armageddon
//
//  Created by Семен Беляков on 12.05.2022.
//

import UIKit

@IBDesignable class HeaderView: UIView {
    @IBInspectable var rightColor = UIColor.rightColorGreen {
        didSet {
            setGradient()
        }
    }
    @IBInspectable var leftColor = UIColor.leftColorGreen {
        didSet {
            setGradient()
        }
    }
    
    var asteroid: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    let small = UIImage(named: "small_asteroid")
    let middle = UIImage(named: "middle_asteroid")
    let big = UIImage(named: "big_asteroid")

    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradient()
        setupConstraints()
    }

    // Градиент headerView
    private func setGradient() {
        (layer as! CAGradientLayer).colors = [rightColor, leftColor]
        (layer as! CAGradientLayer).startPoint = CGPoint(x: 0, y: 1)
        (layer as! CAGradientLayer).endPoint = CGPoint(x: 1, y: 1)
    }

    // Констрейнты астероида
    private func setupConstraints() {
        addSubview(asteroid)

        asteroid.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 27).isActive = true
        asteroid.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -61).isActive = true
    }
}
