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
    
    private var listener: ListenerRegistration?
    
    func addUser(id: String, email: String, username: String, password: String, name_Lname: String, completion: @escaping (String) -> ()) {
        
        db.collection("Users").document(id).setData([
            "email": email,
            "username": username,
            "password": password,
            "name_Lname": name_Lname,
            "titles": "",
            "biography": "",
            "followers": [],
            "following": [],
            "chats": [],
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
    
    //    func saveUserToFirestore(id: String, photoId: String, url: String) {
    //
    //            let postInfos = [
    //                "id": photoId,
    //                "photoUrl": url,
    //                "byLiked": [],
    //                "timestamp": Date()
    //            ] as [String : Any]
    //
    //            db.collection("Users").document(id).updateData([
    //                "posts": FieldValue.arrayUnion([postInfos])
    //            ]) { error in
    //                if let error = error {
    //                    print("Error saving user: \(error.localizedDescription)")
    //                } else {
    //                    print("User successfully saved to Firestore!")
    //                }
    //            }
    //
    //    }
    
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
    
    func addNewChat(user1Id: String, user2Id: String, user1Chats: [String], user2Chats: [String]) {
        
        let chatData: [String: Any] = [
            "allMessages": [],
            "photos": [],
            "timestamp": Date()
        ]
        
        var newUser1Chats = user1Chats
        var newUser2Chats = user2Chats
        
        let setUser1Chats = Set(user1Chats)
        let setUser2Chats = Set(user2Chats)
        let commonIds = setUser1Chats.intersection(setUser2Chats)
        
        let chatID = "\(user1Id)-\(user2Id)"
        
        newUser1Chats.append(chatID)
        newUser2Chats.append(chatID)
        
        
        if commonIds.isEmpty {
            db.collection("Chats").document(chatID).setData(chatData) { error in
                if let error {
                    print("Error adding document: \(error)")
                } else {
                    print("Document added successfully!")
                }
            }
            
            updateUserData(id: user1Id, dataName: "chats", newValue: newUser1Chats) { message in
                print(message)
            }
            updateUserData(id: user2Id, dataName: "chats", newValue: newUser2Chats) { message in
                print(message)
            }
        }
        
    }
    
    func updateChat(userId: String, chatId: String, message: String) {
        let messageData: [String: Any] = [
            "id": UUID().uuidString,
            "userId": userId,
            "text": message,
            "timestamp": Date()
        ]
        
        db.collection("Chats").document(chatId).updateData([
            "allMessages": FieldValue.arrayUnion([messageData]),
            "timestamp": Date()
        ]) { error in
            if let error = error {
                print("Error saving user: \(error.localizedDescription)")
                return
            } else {
                print("message successfully saved to Firestore!")
            }
        }
    }
    
    func getChat(chatId: String, completion: @escaping(Result<Chat, Error>) -> ()) {
        db.collection("Chats").document(chatId).getDocument { document, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let document else { return }
            
            do {
                let chat = try document.data(as: Chat.self)
                completion(.success(chat))
            } catch {
                completion(.failure(error))
            }
            
        }
    }
    
    func getChatList(chatIds: [String], completion: @escaping([Chat]) -> ()) {
        guard !chatIds.isEmpty else { return }
        
        db.collection("Chats").whereField(FieldPath.documentID(), in: chatIds).getDocuments { snapshot, error in
            if let error {
                print(error.localizedDescription)
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            do {
                let chatList = try documents.compactMap { document in
                    try document.data(as: Chat.self)
                }
                completion(chatList)
            } catch {
                print(error.localizedDescription)
                return
            }
            
        }
    }
    
    func listenForMessages(chatID: String, completion: @escaping (Chat) -> ()) {
       listener = db.collection("Chats").document(chatID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                var chat = try document.data(as: Chat.self)
                completion(chat)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func closeListener() {
        listener?.remove()
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
