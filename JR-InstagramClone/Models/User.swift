//
//  User.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation
import FirebaseFirestore

final class User: Codable, Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    // Equatable protokolü için == operatörünü implement edin
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    @DocumentID var id: String?
    var profilePhoto: ProfilePhoto?
    var email: String
    var username: String
    var password: String
    var name_Lname: String
    var titles: String = ""
    var biography: String = ""
    var gender: String = ""
    var timestamp: Date
    
    var followers: [String] = [] // dizi olacak
    var following: [String] = [] // dizi olacak
   // var followRequest: [String] = [] // firestore a ekle
    
    // MARK: -- other values
    
    var postIDs: [String]?

    var posts: [Post] = []
    
    enum CodingKeys: String, CodingKey {
        case id
        case profilePhoto
        case email
        case username
        case password
        case name_Lname
        case titles
        case biography
        case gender
        case followers
        case following
        case postIDs
        case timestamp
        // 'posts' burada yer almıyor, bu nedenle kodlama ve çözme işlemlerine dahil edilmez
    }
    //var chat: [Commend]
    //var stories: [String]
    //var reels: [String]
    
}


