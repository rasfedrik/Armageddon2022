//
//  Extensions.swift
//  Armageddon
//
//  Created by Семен Беляков on 20.04.2022.
//

import Foundation


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
