//
//  ProfileEditViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 31.07.2024.
//

import Foundation
import SwiftUI
import Kingfisher

class ProfileEditViewModel: ObservableObject {
    private let firestoreService = FireStoreService()
    private let storageService = StorageService()
    
    
    func updateUserInfos(id: String, dataName: String, newValue: String, completion: @escaping (String) -> ()) {
        firestoreService.updateUserData(id: id, dataName: dataName, newValue: newValue) { message in
            completion(message)
        }
    }
    
    func getUserInfos(id: String, completion: @escaping (Result<User, Error>) -> ()) {
        firestoreService.getUserInfos(id: id) { result in
            //   guard let self else { return }
            completion(result)
        }
    }
    
    func uploadProfileImage(id: String, image: UIImage, completion: @escaping (String) -> ()) {
        storageService.uploadProfileImage(id: id, image: image) { message in
            
            completion(message)
        }
    }
    
    func uploadPostImage(id: String, image: UIImage, oldPostIDs: [String]?, completion: @escaping (String) -> ()) {
        storageService.uploadNewPostImage(id: id, image: image, oldPostIDs: oldPostIDs) { message in
            completion(message)
        }
    }
    
    func downloadProfileImage(imagePath: String, completion: @escaping (String) -> ()) {
        firestoreService.downloadProfileImage(path: imagePath) { result in
            switch result {
            case .success(let photo):
                completion(photo.photoUrl)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteImage(imagePath: String, completion: @escaping (Bool) -> ()) {
        firestoreService.deleteImage(path: imagePath) { isDeleted in
            completion(isDeleted)
        }
    }
//    
//    func listenForImageUpdates() {
//        firestoreService.listenForImageUpdates()
//    }
//   
}
