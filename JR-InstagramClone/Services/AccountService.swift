//
//  LoginService.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 29.07.2024.
//

import Foundation
import FirebaseAuth

final class AccountService {
    
    private let service = FireStoreService()
    
    func createUser(email: String, password: String, username: String, name_Lname: String, completion: @escaping (String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self else { return }
            
            if let error {
                
                completion(error.localizedDescription)
                return
            }
            
            guard let authResult else {
                return
            }
            
            service.addUser(id: authResult.user.uid, email: email, username: username, password: password, name_Lname: name_Lname) { text in
                completion(text)
            }
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard self != nil else { return }
          
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let authResult else { return }
            
            completion(.success(authResult))
            
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
          
        }
    }
    
}
