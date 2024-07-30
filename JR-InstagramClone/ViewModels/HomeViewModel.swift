//
//  HomeViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 30.07.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    private let service = FireStoreService()
    
    func getUserInfos(id: String, completion: @escaping(Result<User, Error>) ->() ) {
        service.getUserInfos(id: id) { result in
            completion(result)
        }
    }
}
