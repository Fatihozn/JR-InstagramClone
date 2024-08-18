//
//  Story.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 15.08.2024.
//

import Foundation
import FirebaseFirestore

final class Story: Codable {
    @DocumentID var id: String?
    var photoUrl: String
    var seenBy: [String]?
    var timestamp: Date
}
