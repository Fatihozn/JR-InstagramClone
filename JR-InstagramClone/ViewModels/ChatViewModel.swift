//
//  ChatViewModel.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 9.08.2024.
//

import Foundation


class ChatViewModel: ObservableObject {
    private var service = FireStoreService()
    
    @Published var ChatList: [Chat]?
    @Published var Messages: [ChatMessage] = []

    func listenForMessages(chatID: String) {
        service.listenForMessages(chatID: chatID) { newChat in
            self.Messages = newChat.allMessages ?? []
        }
    }
    
    func closeListener() {
        service.closeListener()
    }
    
    func getChat(chatId: String) {
        service.getChat(chatId: chatId) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let chat):
                DispatchQueue.main.async {
                    self.Messages = chat.allMessages ?? []
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateChat(userId: String, chatId: String, message: String) {
        service.updateChat(userId: userId, chatId: chatId, message: message)
    }
    
    func getChatList(userId: String, chatIds: [String]) {
        service.getChatList(chatIds: chatIds) { [weak self] chatList in
            guard let self else { return }
            defineUserOfPost(userId: userId, chatList: chatList)
        }
    }
    
    private func defineUserOfPost(userId: String, chatList: [Chat]) {
        let dispatchGroup = DispatchGroup()
            var updatedChatList: [Chat] = []

            for chat in chatList {
                if let splittedId = chat.id?.split(separator: "-") {
                    let user2Id = splittedId[0] == userId ? splittedId[1] : splittedId[0]
                    
                    dispatchGroup.enter()
                    let updatedChat = chat

                    service.getUserInfos(id: String(user2Id)) { result in
                        switch result {
                        case .success(let user):
                            updatedChat.user = user
                            updatedChatList.append(updatedChat)
                        case .failure(let error):
                            print(error)
                        }
                        dispatchGroup.leave()
                    }
                }
             
            }

            dispatchGroup.notify(queue: .main) {
                self.ChatList = updatedChatList.sorted { $0.timestamp > $1.timestamp }
            }
    }
}
