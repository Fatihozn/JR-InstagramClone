//
//  User.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation
import FirebaseFirestore

final class User: Codable {
    
    @DocumentID var id: String?
    var profilePhoto: String = ""
    var email: String
    var username: String
    var password: String
    var name_Lname: String
    var titles: String = ""
    var biography: String = ""
    var gender: String = ""
    
    var followers: Int = 0
    var following: Int = 0
    
    // MARK: -- other values
    
    //var chat: [Commend]
    //var stories: [String]
    //var reels: [String]
    //var posts: [Post]
}


