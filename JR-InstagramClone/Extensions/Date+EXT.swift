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
    
    func hourFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        let formattedDate = dateFormatter.string(from: self)
        return formattedDate
    }
    
    func hourDiffrence() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let hoursDiffrence = calendar.dateComponents([.hour], from: self, to: currentDate).hour ?? 0
        
        if hoursDiffrence < 24 {
            return "\(hoursDiffrence)s"
        } else {
            return "eski"
        }
    }

    func timeDifference() -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        // Saat farkını hesapla
        let hoursDifference = calendar.dateComponents([.hour], from: self, to: currentDate).hour ?? 0
        
        if hoursDifference < 24 {
            // 24 saatten azsa saat farkını döndür
            return "\(hoursDifference) saat önce"
        }
        
        // Gün farkını hesapla
        let daysDifference = calendar.dateComponents([.day], from: self, to: currentDate).day ?? 0
        
        if daysDifference < 29 {
            // 2 haftadan azsa gün farkını döndür
            return "\(daysDifference) gün önce"
        }
        
        let yearsDifference = calendar.dateComponents([.year], from: self, to: currentDate).year ?? 0
        
        if yearsDifference > 1 {
            return "\(yearsDifference) yıl önce"
        }
        
        // 2 haftadan fazlaysa tarihi döndür
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d"
        
        return formatter.string(from: self)
    }

}
