//
//  Post.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation

final class Post: Codable {
    var id: String
    var photo: String
    var likes: Int
    var commends: [Comment]
    var time: String
}
