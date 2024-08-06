//
//  Image.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 1.08.2024.
//

import Foundation
import FirebaseFirestore

final class ProfilePhoto: Codable {
    var id: String
    var photoUrl: String
    var timestamp: Date
}
