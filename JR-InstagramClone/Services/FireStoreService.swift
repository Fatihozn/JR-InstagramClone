//
//  FireStoreService.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage

final class FireStoreService {
    
    let db = Firestore.firestore()
    
    func addUser(id: String, email: String, username: String, password: String, name_Lname: String, completion: @escaping (String) -> ()) {
        
        db.collection("Users").document(id).setData([
            "email": email,
            "username": username,
            "password": password,
            "name_Lname": name_Lname,
            "titles": "",
            "biography": "",
            "followers": 0,
            "following": 0,
            "gender": "",
            "timestamp": FieldValue.serverTimestamp()
        ]) { error in
            
            if let error {
                completion(error.localizedDescription)
            } else {
                completion("Kayıt Başarılı")
            }
        }
        
    }
    
    func getUserInfos(id: String, completion: @escaping (Result<User, Error>) -> ()) {
        
        db.collection("Users").document(id).getDocument { document, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let document else { return }
            
            do {
                let user = try document.data(as: User.self)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
            
        }
        
    }
    
    func updateUserData(id: String, dataName: String, newValue: Any, completion: @escaping (String) -> ()) {
        db.collection("Users").document(id).updateData([
            dataName: newValue
        ]) { error in
            if let error {
                completion(error.localizedDescription)
            } else {
                completion("Güncellendi")
            }
        }
        
    }
    
    func addUserProfilImage(userId: String, photoId: String, photoUrl: String, completion: @escaping (String) -> ()) {
        let PhotoRef = db.collection("Users").document(userId)
        
        let profileInfos = [
            "id": photoId,
            "photoUrl": photoUrl,
            "timestamp": FieldValue.serverTimestamp()
        ] as [String : Any]
        
        PhotoRef.updateData([
            "profilePhoto": profileInfos
        ]) { err in
            if let err = err {
                completion(err.localizedDescription)
            } else {
                completion("Güncellendi")
            }
        }
    }
    
    func uploadToImages(userID: String, photoId: String, collectionName: ImageType, photoUrl: String, completion: @escaping (Bool) -> ()) {
        
        let documentData: [String: Any] = [
            "userID": userID,
            "photoUrl": photoUrl,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection(collectionName.rawValue).document(photoId).setData(documentData) { error in
            if let error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func updatePostData(id: String, dataName: String, newValue: Any, completion: @escaping (String) -> ()) {
        db.collection("PostImages").document(id).updateData([
            dataName: newValue
        ]) { error in
            if let error {
                completion(error.localizedDescription)
            } else {
                completion("Güncellendi")
            }
        }
        
    }
    
    func addUserPostImage(userId: String, photoId: String, oldPostIDs: [String]?, completion: @escaping (String) -> ()) {
        let PhotoRef = db.collection("Users").document(userId)
        
        var postIDs: [String]
        if let oldPostIDs {
            postIDs = oldPostIDs
        } else {
            postIDs = [String]()
        }
        
        postIDs.append(photoId)
        
        PhotoRef.updateData([
            "postIDs": postIDs
        ]) { err in
            if let err = err {
                completion(err.localizedDescription)
            } else {
                completion("Güncellendi")
            }
        }
    }
    
    func downloadProfileImage(path: String, completion: @escaping (Result<ProfilePhoto, Error>) -> ()) {
        db.collection("ProfileImages").document(path).getDocument { document, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let document else { return }
            
            do {
                let photo = try document.data(as: ProfilePhoto.self)
                completion(.success(photo))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func downloadPostImage(path: String, completion: @escaping (Result<Post, Error>) -> ()) {
        db.collection("PostImages").document(path).getDocument { document, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let document else { return }
            
            do {
                let post = try document.data(as: Post.self)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func downloadAllPosts(_ ignorePosts: [String], completion: @escaping (Result<[Post], Error>) -> ()) {
        db.collection("PostImages").getDocuments { collection, error in
            if let error {
                completion(.failure(error))
            }
            
            guard let documents = collection?.documents else { return }
            
            do {
                let filtredList = documents.filter { !ignorePosts.contains($0.documentID) }
                
                let posts = try filtredList.compactMap { document in
                    try document.data(as: Post.self)
                }
                
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
            
        }
    }
    
    
    func deleteImage(path: String, completion: @escaping(Bool) -> ()) {
        db.collection("ProfileImages").document(path).delete() { error in
            if let error {
                print(error.localizedDescription)
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    
    
    
}
