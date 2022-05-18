//
//  Extensions.swift
//  Armageddon
//
//  Created by Семен Беляков on 20.04.2022.
//

import Foundation
import UIKit

// Вычисление среднего размера объекта
extension Double {
    func average(x: Double) -> String {
        return String((Int(x + self) / 2))
    }
}

// Изменение отображения формата даты
extension Date {
    func toStringUS() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    func toStringLocal() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.calendar = .current
        dateFormatter.timeZone = .current
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    func cleanPrice() -> String {
            let doubleValue = Int(Double(self) ?? 0.0)
        
            let formatter = NumberFormatter()
        
            formatter.maximumFractionDigits = 2
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "ru_RU")
            return formatter.string(from: NSNumber(value: doubleValue)) ?? "\(doubleValue)"
    }
}

extension UIColor {
    static let leftColorRed = UIColor(red: 255.0/255.0, green: 177.0/255.0, blue: 153.0/255.0, alpha: 1.0).cgColor
    static let rightColorRed = UIColor(red: 255.0/255.0, green: 8.0/255.0, blue: 68.0/255.0, alpha: 1.0).cgColor
    
    static let leftColorGreen = UIColor(red: 207.0/255.0, green: 243.0/255.0, blue: 125.0/255.0, alpha: 1.0).cgColor
    static let rightColorGreen = UIColor(red: 125.0/255.0, green: 232.0/255.0, blue: 140.0/255.0, alpha: 1.0).cgColor
}
