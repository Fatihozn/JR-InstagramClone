//
//  LoginViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 26.07.2024.
//

import Foundation
import FirebaseAuth


class Login_SignupViewModel: ObservableObject {
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
          // ...
            print(authResult)
            print(error)
        }
    }
    
    func signInUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let self else { return }
          // ...
        }
    }
}
