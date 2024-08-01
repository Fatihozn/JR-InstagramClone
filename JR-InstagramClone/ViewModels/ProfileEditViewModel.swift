//
//  ProfileEditViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 31.07.2024.
//

import Foundation
import SwiftUI

class ProfileEditViewModel: ObservableObject {
    private let firestoreService = FireStoreService()
    private let storageService = StorageService()
    
    private var isDownloading = false
    
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
    
    func uploadImage(id: String, image: UIImage, completion: @escaping (String) -> ()) {
        storageService.uploadImage(id: id, image: image) { message in
            
            completion(message)
        }
    }
    
    func downloadImage(imagePath: String, completion: @escaping (UIImage) -> ()) {
        guard !isDownloading else { return }
        isDownloading = true
        storageService.downloadImage(path: imagePath) { data in
            self.isDownloading = false
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print("fotoğraf çevirilemedi")
            }
            
        }
    }
    
    func deleteImage(imagePath: String, completion: @escaping (Bool) -> ()) {
        storageService.deleteImage(path: imagePath) { isDeleted in
            completion(isDeleted)
        }
    }
}
