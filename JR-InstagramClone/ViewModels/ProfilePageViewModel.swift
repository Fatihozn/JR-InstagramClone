//
//  ProfilePageViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 4.08.2024.
//

import Foundation

class ProfilePageViewModel: ObservableObject {
    private let firestoreService = FireStoreService()
    
    func getUserInfos(id: String, completion: @escaping (User?) -> ()) {
        firestoreService.getUserInfos(id: id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadPostImages(postID: String, completion: @escaping (Post) -> ()) {
            firestoreService.downloadPostImage(path: postID) { result in
                switch result {
                case .success(let post):
                    completion(post)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            
        }
    }
    
    func addToList(_ list: [String], userId: String, friendId: String, dataName: String, completion: @escaping (Bool) -> ()) {
        var newList = list
        
        if !newList.contains(friendId) {
            
            newList.append(friendId)
            
            firestoreService.updateUserData(id: userId, dataName: dataName, newValue: newList) { message in
                if message == "Güncellendi" {
                    completion(true)
                } else {
                    completion(false)
                }
                
            }
        }
        
    }
    
    func removeFromList(_ list: [String], userId: String, friendId: String, dataName: String, completion: @escaping (Bool) -> ()) {
        var newList = list
        
        if let index = newList.firstIndex(of: friendId) {
            newList.remove(at: index)
            
            firestoreService.updateUserData(id: userId, dataName: dataName, newValue: newList) { message in
                if message == "Güncellendi" {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
    
    func addToChats(user1Id: String, user2Id: String, user1Chats: [String], user2Chats: [String]) {
        firestoreService.addNewChat(user1Id: user1Id, user2Id: user2Id, user1Chats: user1Chats, user2Chats: user2Chats)
    }

}
