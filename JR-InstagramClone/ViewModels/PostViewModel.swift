//
//  PostViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 4.08.2024.
//

import Foundation

class PostViewModel: ObservableObject {
    private let service = FireStoreService()
    
    func updatePostData(id: String, dataName: String, newValue: Any, completion: @escaping (String) -> ()) {
        service.updatePostData(id: id, dataName: dataName, newValue: newValue) { message in
            completion(message)
        }
    }
    
    func downloadPostImage(id: String, completion: @escaping (Post) -> ()) {
        service.downloadPostImage(path: id) { result in
            switch result {
            case .success(let post):
                self.getUserInfos(id: post.userID) { user in
                    post.user = user
                    completion(post)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
   private func getUserInfos(id: String, completion: @escaping (User) -> ()) {
        service.getUserInfos(id: id) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
