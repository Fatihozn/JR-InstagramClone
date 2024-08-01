//
//  Image.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 1.08.2024.
//

import Foundation
import FirebaseFirestore

final class ProfilePhoto: Codable {
    @DocumentID var id: String?
    var timestamp: Date
    var url: String
}
