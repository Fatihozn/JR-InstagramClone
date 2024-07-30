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
            "profilePhoto": "",
            "followers": 0,
            "following": 0,
            "gender": ""
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
    
    func updateUserData(id: String, dataName: String, newValue: String, completion: @escaping (String) -> ()) {
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
    
    
}
