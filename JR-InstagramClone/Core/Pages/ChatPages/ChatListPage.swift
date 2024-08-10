//
//  ChatList.swift
//  JR-InstagramClone
//
//  Created by Fatih Özen on 8.08.2024.
//

import SwiftUI

struct ChatListPage: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var globalClass: GlobalClass
    @ObservedObject private var viewModel = ChatViewModel()
    
    var body: some View {
        
        NavigationStack {
            List {
                if let chatList = viewModel.ChatList {
                    ForEach(chatList, id: \.id) { chat in
                        ChatListItem(chat: chat)
                    }
                }
                
            }
            .navigationTitle("Sohbetler")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarBackButtonHidden()
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
            .tint(.white)
        }
        .onAppear {
            if let user = globalClass.User {
                viewModel.getChatList(userId: user.id ?? "", chatIds: user.chats ?? [])
            }
        }
        
        
    }
}

