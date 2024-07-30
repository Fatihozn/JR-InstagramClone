//
//  String+EXT.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: self)
    }
}
