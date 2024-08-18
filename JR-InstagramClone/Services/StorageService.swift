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
    
    func uploadProfileImage(id: String, image: UIImage, completion: @escaping (Bool) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(false)
            return
        }
        
        let photoId = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: "ProfileImages/\(photoId)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            
            guard let self else { return }
            
            if error != nil {
                completion(false)
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self else { return }
                if error != nil {
                    completion(false)
                    return
                }
                
                guard let downloadURL = url else {
                    completion(false)
                    return
                }
                
                fireStoreService.uploadToImages(userID: id, photoId: photoId, collectionName: .profile, photoUrl: downloadURL.absoluteString) {[weak self] isUploaded in
                    guard let self else { return }
                    
                    if isUploaded {
                        fireStoreService.addUserProfilImage(userId: id, photoId: photoId, photoUrl: downloadURL.absoluteString) { isAdded in
                                completion(isAdded)
                        }
                    }
                }
                
            }
            
        }
    }
    
    func uploadNewPostImage(id: String, image: UIImage, oldPostIDs: [String]?, completion: @escaping (Bool) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(false)
            return
        }
        
        let photoId = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: "PostImages/\(photoId)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            
            guard let self else { return }
            
            if error != nil {
                completion(false)
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self else { return }
                if error != nil {
                    completion(false)
                    return
                }
                
                guard let downloadURL = url else {
                    completion(false)
                    return
                }
                
                fireStoreService.uploadToImages(userID: id, photoId: photoId, collectionName: .post, photoUrl: downloadURL.absoluteString) {[weak self] isUploaded in
                    guard let self else { return }
                    
                    if isUploaded {
                        fireStoreService.addUserPostImage(userId: id, photoId: photoId, oldPostIDs: oldPostIDs) { isAdded in
                            completion(isAdded)
                        }
                    }
                }
                
            }
            
        }
    }
    
    
    func uploadNewStoryImage(userId: String, image: UIImage, completion: @escaping (Bool) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(false)
            return
        }
        
        let photoId = "\(UUID().uuidString).jpg"
        let storageRef = storage.reference(withPath: "StoryImages/\(photoId)")
        
        storageRef.putData(imageData, metadata: nil) { [weak self] _, error in
            
            guard let self else { return }
            
            if error != nil {
                completion(false)
                return
            }
            
            storageRef.downloadURL { [weak self] url, error in
                guard let self else { return }
                if error != nil {
                    completion(false)
                    return
                }
                
                guard let downloadURL = url else {
                    completion(false)
                    return
                }
                
                fireStoreService.addStory(userId: userId, photoId: photoId, photoUrl: downloadURL.absoluteString) { isAdded in
                    completion(isAdded)
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
