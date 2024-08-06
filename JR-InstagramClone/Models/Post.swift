//
//  Post.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation
import FirebaseFirestore

final class Post: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equatable protokolü için == operatörünü implement edin
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
    @DocumentID var id: String?
    var photoUrl: String
    var userID: String
    var byLiked: [String]?
    //var commends: [Comment]?
    var timestamp: Date
    
    var user: User?
    
    enum CodingKeys: CodingKey {
        case id
        case photoUrl
        case userID
        case byLiked
        case timestamp
    }
    
}
