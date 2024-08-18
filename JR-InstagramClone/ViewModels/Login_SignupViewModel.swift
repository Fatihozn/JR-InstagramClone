//
//  LoginViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 26.07.2024.
//

import Foundation
import FirebaseAuth


class Login_SignupViewModel: ObservableObject {
    
    private var authService = AccountService()
    private var fireStoreService = FireStoreService()
    
    func createUser(email: String, password: String, username: String, name_Lname: String, completion: @escaping (String) -> Void) {
        authService.createUser(email: email, password: password, username: username, name_Lname: name_Lname) { message in
            completion(message)
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> Void) {
        authService.signInUser(email: email, password: password) { result in
            completion(result)
        }
    }
    
    func resetPassword(email: String) {
        authService.resetPassword(email: email)
    }
    
    func getUserInfos(id: String, completion: @escaping(Result<User?, Error>) ->()) {
        fireStoreService.getUserInfos(id: id) { result in
            completion(result)
        }
    }
}
