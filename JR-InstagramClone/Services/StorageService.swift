//
//  StorageService.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 31.07.2024.
//

import Foundation
import SwiftUI
import FirebaseStorage

final class StorageService {
    private let storage = Storage.storage()
    private var fireStoreService = FireStoreService()
    
    func uploadImage(id: String, image: UIImage, completion: @escaping (String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion("Failed to get image data.")
            return
        }
        
        let storageRef = storage.reference()
        let photoPath = "\(UUID().uuidString).jpg"
        let photoRef = storageRef.child("images/\(photoPath)")
        
        photoRef.putData(imageData, metadata: nil) { [weak self] _, error in
            guard let self else { return }
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            
            fireStoreService.updateUserData(id: id, dataName: "profilePhoto", newValue: photoPath) { message in
                if message == "Güncellendi" {
                    completion("Yükleme Başarılı")
                }
            }
            
            
        }
    }
    
    func downloadImage(path: String, completion: @escaping (Data) -> ()) {
        let storageRef = storage.reference(withPath: "images/\(path)")
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                return
            }
            if let data = data {
               completion(data)
            }
        }
    }
    
    func deleteImage(path: String, completion: @escaping (Bool) -> ()) {
        let storageRef = storage.reference(withPath: "images/\(path)")
        
        storageRef.delete { error in
            print(error?.localizedDescription)
            if error != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
}
