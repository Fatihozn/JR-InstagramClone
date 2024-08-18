//
//  StoryViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 17.08.2024.
//

import Foundation

class StoryViewModel: ObservableObject {
    private var service = FireStoreService()
    
    func updateStory(userId: String, storyId: String, oldSeenBy: [String], mainUserId: String, completion: @escaping(Bool) -> ()) {
        var newSeenBy = oldSeenBy
        
        if !oldSeenBy.contains(mainUserId) {
            newSeenBy.append(mainUserId)
            service.updateStory(userId: userId, storyId: storyId, newSeenBy: newSeenBy) { isUpdated in
                completion(isUpdated)
            }
        }
        
    }
    
    func getUserInfos(userId: String, completion: @escaping (User?) -> ()) {
        service.getUserInfos(id: userId) { result in
            switch result {
            case .success(let user):
                completion(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
