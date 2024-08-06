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
    
    func downloadAllPost(_ ignorePosts: [String], completion: @escaping ([Post]) -> ()) {
        service.downloadAllPosts(ignorePosts) { result in
            switch result {
            case .success(let posts):
                self.defineUserOfPost(posts: posts) { newPosts in
                    completion(newPosts)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func defineUserOfPost(posts: [Post], completion: @escaping ([Post]) -> ()) {
        let dispatchGroup = DispatchGroup()
            var updatedPosts: [Post] = []

            for post in posts {
                dispatchGroup.enter()
                let updatedPost = post

                service.getUserInfos(id: post.userID) { result in
                    switch result {
                    case .success(let user):
                        updatedPost.user = user
                        updatedPosts.append(updatedPost)
                    case .failure(let error):
                        print(error)
                    }
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                completion(updatedPosts)
            }
    }
}
