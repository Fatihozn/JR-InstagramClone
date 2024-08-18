//
//  Chat.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 13.08.2024.
//

import Foundation
import FirebaseFirestore

final class Chat: Codable {
    @DocumentID var id: String?
    var allMessages: [ChatMessage]?
    var photos: [String]?
    var timestamp: Date
    
    var user: User?
    
    enum CodingKeys: String, CodingKey {
        case id
        case allMessages
        case photos
        case timestamp
    }
}

final class ChatMessage: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equatable protokolü için == operatörünü implement edin
    static func == (lhs: ChatMessage, rhs: ChatMessage) -> Bool {
        return lhs.id == rhs.id
    }
    
    var id: String
    var userId: String
    var text: String
    var timestamp: Date
}
