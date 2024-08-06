//
//  Date+EXT.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 3.08.2024.
//

import Foundation

extension Date {
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YYYY" // Gün-Ay-Yıl formatı

        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
}
