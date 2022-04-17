//
//  CellsShadow.swift
//  Armageddon
//
//  Created by Семен Беляков on 17.04.2022.
//

import UIKit

class CellsShadow: UIView {
    override var bounds: CGRect {
        didSet {
            setupShadow()
        }
    }
    
    private func setupShadow() {
        layer.cornerRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
     }
}


