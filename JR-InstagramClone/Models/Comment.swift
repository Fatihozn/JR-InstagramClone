//
//  Comment.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation

final class Comment: Codable {
    var id: String
    var senderID: String
    var sendedID: String
    var text: String
}
