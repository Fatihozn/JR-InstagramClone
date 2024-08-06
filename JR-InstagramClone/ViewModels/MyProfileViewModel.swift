//
//  MyProfileViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 3.08.2024.
//

import Foundation

class MyProfileViewModel: ObservableObject {
    private let firestoreService = FireStoreService()
    
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
}
