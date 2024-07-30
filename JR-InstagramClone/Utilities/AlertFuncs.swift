//
//  AlertFuncs.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import Foundation
import SwiftUI

struct AlertFuncs {
    static func createOneButtonAlert(title: String, description: String) -> Alert {
        Alert(title: Text(title),
              message: Text(description),
              dismissButton: .default(Text("Tamam"), action: {
        }))
    }
}
