//
//  StorageService.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 31.07.2024.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

enum ImageType: String {
    case profile = "ProfileImages"
    case post = "PostImages"
}

final class StorageService {
    private let storage = Storage.storage()
    private var fireStoreService = FireStoreService()
    
    func uploadProfileImage(id: String, image: UIImage, completion: @escaping (String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion("Failed to get image data.")
            return
        }
        
        let photoId = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: "ProfileImages/\(photoId)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            
            guard let self else { return }
            
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self else { return }
                if let error {
                    completion(error.localizedDescription)
                    return
                }
                
                guard let downloadURL = url else {
                    completion(NSError(domain: "DownloadURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Download URL is nil"]).localizedDescription )
                    return
                }
                
                fireStoreService.uploadToImages(userID: id, photoId: photoId, collectionName: .profile, photoUrl: downloadURL.absoluteString) {[weak self] isUploaded in
                    guard let self else { return }
                    
                    if isUploaded {
                        fireStoreService.addUserProfilImage(userId: id, photoId: photoId, photoUrl: downloadURL.absoluteString) { message in
                            if message == "Güncellendi" {
                                completion("Yükleme Başarılı")
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    
    func uploadNewPostImage(id: String, image: UIImage, oldPostIDs: [String]?, completion: @escaping (String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion("Failed to get image data.")
            return
        }
        
        let photoId = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: "PostImages/\(photoId)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            
            guard let self else { return }
            
            if let error = error {
                completion(error.localizedDescription)
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self else { return }
                if let error {
                    completion(error.localizedDescription)
                    return
                }
                
                guard let downloadURL = url else {
                    completion(NSError(domain: "DownloadURL", code: -1, userInfo: [NSLocalizedDescriptionKey: "Download URL is nil"]).localizedDescription )
                    return
                }
                
                fireStoreService.uploadToImages(userID: id, photoId: photoId, collectionName: .post, photoUrl: downloadURL.absoluteString) {[weak self] isUploaded in
                    guard let self else { return }
                    
                    if isUploaded {
                        fireStoreService.addUserPostImage(userId: id, photoId: photoId, oldPostIDs: oldPostIDs) { message in
                            if message == "Güncellendi" {
                                completion("Yükleme Başarılı")
                            }
                        }
                    }
                }
                
            }
            
        }
    }
    

    
}





//    func downloadImage(path: String, completion: @escaping (Data) -> ()) {
//        let storageRef = storage.reference(withPath: "images/\(path)")
//        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//            if let error = error {
//                print("Error downloading image: \(error.localizedDescription)")
//                return
//            }
//            if let data = data {
//                completion(data)
//            }
//        }
//    }

//    func deleteImage(path: String, completion: @escaping (Bool) -> ()) {
//        let storageRef = storage.reference(withPath: "images/\(path)")
//
//        storageRef.delete { [weak self] error in
//            guard let self else { return }
//            if let error {
//                print(error.localizedDescription)
//                completion(false)
//                return
//            }
//            fireStoreService.deleteImage(path: path) { isDeleted in
//                if isDeleted  {
//                    completion(true)
//                } else {
//                    completion(false)
//                }
//            }
//        }
//    }
