//
//  GloballClass.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import Foundation
import SwiftUI

final class GlobalClass: ObservableObject {
    
    static let shared = GlobalClass()
    
    let fireStoreService = FireStoreService()
    
    init () { }
    
    @Published var User: User?
    
    func updatedMainUser(id: String) {
        if let User {
            fireStoreService.getUserInfos(id: User.id ?? "") { result in
                switch result {
                case .success(let user):
                    self.User = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            fireStoreService.getUserInfos(id: id) { resul in
                switch resul {
                case .success(let user):
                    self.User = user
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
